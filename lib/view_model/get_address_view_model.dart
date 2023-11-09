import 'package:PaletPoint/model/address_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_url.dart';
import '../service/get_services.dart';
import '../view/invoice_view/generate_invoice.dart';

final getAddressFutureProvider =
    FutureProvider.autoDispose<List<AddressModel>>((ref) async {
  final apiService = ApiService();
  Response response;
  try {
    response = await apiService.get(url: ApiUrls.address);
  } catch (e) {
    rethrow;
  }
  List<AddressModel> _addressModelList = [];
  if (response.data['addresses'] != null) {
    _addressModelList = (response.data['addresses'] as List)
        .map((e) => AddressModel.fromMap(e))
        .toList();
  }

  ref.read(invoiceTableProvider.notifier).state.contactInformationId = _addressModelList[0];

  


  return _addressModelList;
});
