import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/api_url.dart';
import '../../service/post_service.dart';
import '../../view/proposal_view/proposal_detail.dart';
import '../get_notifications_view_model.dart';
import 'get_proposal_view_model.dart';


final createProposalProvider = FutureProvider.autoDispose((ref) async {
  final apiService = PostService();
  Response response;
  List<FormItem> _formItems = await ref.watch(formItemProvider);
  OfferModel _contentItems = await ref.watch(offerModelProvider);

  Map<String, dynamic> _productsAttributes = {};

  for (int i = 0; i < _formItems.length; i++) {
    if (_formItems[i].price != null && _formItems[i].price != 0.0) {
      _productsAttributes['$i'] = {
        "id": _formItems[i].productId.toString(),
        "price": _formItems[i].price.toString(),
        "proposal_note": _formItems[i].note,
        "currency_unit": _formItems[i].currencies,
        if(_formItems[i].image != null) 'image': _formItems[i].image
      };
    }
  }

  debugPrint(_productsAttributes.toString());

  Map<String, dynamic> data = {
    "id": _contentItems.proposalId,
    "valid_period": _contentItems.validPeriod,
    "delivery_time": _contentItems.deliveryTime,
    "payment_type": null,
    "products_proposals_attributes": _productsAttributes
  };


  final formData = FormData.fromMap(data);

  try {
    response = await apiService.postFormdata(url: ApiUrls.replyProposal, data: formData);
    await ref.refresh(getProposalProvider);
    ref.read(getProposalProvider.future);
    await ref.refresh(getNotificationProvider);
    ref.read(getNotificationProvider.future);
  } catch (e) {
    rethrow;
  }

  return response;
});

//For read value on detail_product widget
class FormItem {
  int? productId;
  double? price;
  String? note;
  int? currencies;
  MultipartFile? image;
  XFile? imageXfile;
  
  FormItem({this.productId, this.price, this.note, this.currencies, this.image, this.imageXfile});

  FormItem copyWith({int? productId, double? price, String? note, int? currencies, MultipartFile? image, XFile? imageXfile, bool clearImage = false,
  bool clearImageXfile = false,}) {
    return FormItem(
        productId: productId ?? this.productId,
        price: price ?? this.price,
        note: note ?? this.note,
        currencies: currencies ?? this.currencies,
        imageXfile: imageXfile ?? this.imageXfile,
        image: image ?? this.image);
  }
  String? get getNote{
    return note;
  }
  void nullImage(){
    image = null;
  }
}

final formItemProvider = StateNotifierProvider<FormItemModelNotifier, List<FormItem>>((ref) {
  return FormItemModelNotifier();
});

class FormItemModelNotifier extends StateNotifier<List<FormItem>> {
  FormItemModelNotifier() : super([]);
  
  void addFormItem(FormItem form, int productId) {
  // Check if a formItem with the same productId already exists
  if (state.any((item) => item.productId == productId)) {
    // Handle the case where a formItem with the same productId already exists
    // You can return an error, update the existing item, or take any other action as needed.
    // In this example, we'll just update the existing item.
    state = state.map((item) {
      if (item.productId == productId) {
        // Update the existing item with the new values from 'form'
        return item.copyWith(
          image: form.image,
          price: form.price,
          currencies: form.currencies,
          note: form.note,
        );
      } else {
        return item;
      }
    }).toList();
  } else {
    // If there is no existing item with the same productId, add the new formItem
    form.productId = productId;
    form.currencies = 0;
    state = [...state, form];
  }
}


  void addImage(int productId, MultipartFile image, XFile imageXfile) {
    state = [
      for (final form in state)
        if (form.productId == productId)
          form.copyWith(image: image, imageXfile: imageXfile)
        else 
          form
    ];
  }

  void addPrice(int productId, double price) {
    state = [
      for (final form in state)
        if (form.productId == productId) form.copyWith(price: price) else form
    ];
  }

  void addCurrencies(int productId, int currencies) {
    state = [
      for (final form in state)
        if (form.productId == productId)
          form.copyWith(currencies: currencies)
        else
          form
    ];
  }

  void updateImage(int productId, MultipartFile image) {
    state = [
      for (final form in state)
        if (form.productId == productId)
          form.copyWith(image: image)
        else
          form
    ];
  }
  void removeImage(int productId) {
    state = state.map((form) {
      if (form.productId == productId) {
        form.nullImage(); //function that converts image to null value
        return form; // update form
      } else {
        return form; // return form
      }
    }).toList();
  }
  void addNote(int productId, String note) {
    state = [
      for (final form in state)
        if (form.productId == productId) 
          form.copyWith(note: note) 
        else 
          form
    ];
  }
  bool isImageSelected(int productId) {
    for (final form in state) {
      if (form.productId == productId) {
        return form.image != null;
      }
    }
    return false;
  }
  XFile? isImageXfile(int productId) {
    for (final form in state) {
      if (form.productId == productId) {
        return form.imageXfile;
      }
    }
    return null;
  }

}