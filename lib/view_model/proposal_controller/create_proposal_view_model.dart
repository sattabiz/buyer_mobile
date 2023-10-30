import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/api_url.dart';
import '../../service/post_service.dart';
import '../../view/proposal_view/proposal_detail.dart';
import '../get_notifications_view_model.dart';
import 'get_proposal_view_model.dart';

//for
final createProposalProvider = FutureProvider.autoDispose((
  ref,
) async {
  final apiService = PostService();
  Response response;
  List<FormItem> _formItems = await ref.watch(formItemProvider);
  OfferModel _contentItems = await ref.watch(offerModelProvider);

  Map<String, dynamic> _productsAttributes = {};

  for (int i = 0; i < _formItems.length; i++) {
    _productsAttributes['$i'] = {
      "id": _formItems[i].productId.toString(),
      "price": _formItems[i].price.toString(),
      "proposal_note": _formItems[i].note,
      "currency_unit": _formItems[i].currencies,
      // "products_proposal_files": _formItems[i].image,
    };
  }

  Map<String, dynamic> data = {
    "id": _contentItems.proposalId,
    "valid_period": _contentItems.validPeriod,
    "delivery_time": _contentItems.deliveryTime,
    "payment_type": null,
    "products_proposals_attributes": _productsAttributes
  };

  final formData3 = FormData.fromMap(data);

  try {
    response = await apiService.postFormdata(
        url: ApiUrls.replyProposal, data: formData3);
    await ref.refresh(getProposalProvider);
    ref.read(getProposalProvider.future);
    await ref.refresh(getNotificationProvider);
    ref.read(getNotificationProvider.future);
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        //ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
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
  FormItem(
      {this.productId, this.price, this.note, this.currencies, this.image});
  FormItem copyWith(
      {int? productId,
      double? price,
      String? note,
      int? currencies,
      MultipartFile? image}) {
    return FormItem(
        productId: productId ?? this.productId,
        price: price ?? this.price,
        note: note ?? this.note,
        currencies: currencies ?? this.currencies,
        image: image ?? this.image);
  }
}

final formItemProvider =
    StateNotifierProvider<FormItemModelNotifier, List<FormItem>>((ref) {
  return FormItemModelNotifier();
});

class FormItemModelNotifier extends StateNotifier<List<FormItem>> {
  FormItemModelNotifier() : super([]);
  void addFormItem(FormItem form, int productId) {
    form.productId = productId;
    form.currencies = 0;
    state = [...state, form];
  }

  void addImage(int productId, MultipartFile image) {
    state = [
      for (final form in state)
        if (form.productId == productId)
          form.copyWith(image: image)
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

  void addNote(int productId, String note) {
    state = [
      for (final form in state)
        if (form.productId == productId) form.copyWith(note: note) else form
    ];
  }
}
