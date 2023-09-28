import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_url.dart';
import '../model/invoice_model.dart';
import '../service/get_services.dart';
import 'get_order_view_model.dart';

final getInvoicesProvider =
    FutureProvider.autoDispose<List<InvoiceModel>>((ref) async {
  final apiService = ApiService();
  Response response;
  try {
    debugPrint('provider calisti');
    response = await apiService.get(url: ApiUrls.invoices);
    debugPrint(response.data.toString());
  } catch (error) {
    if (error is DioException) {
      if (error.response?.statusCode != 200) {
        debugPrint(error.response!.statusCode.toString());
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }
  //debugPrint('_invoicesList[0].products![0].categoryId.toString()');
  debugPrint(response.data.toString());
  List<InvoiceModel> _invoicesList = [];
  if (response.data['invoices'] != null) {
    _invoicesList = (response.data['invoices'] as List)
        .map((e) => InvoiceModel.fromMap(e))
        .toList();
  }
  /* debugPrint('sadasfffasddsadsdsaas');
  debugPrint(_invoicesList[1].products![0].categoryId.toString()); */
  _invoicesList.sort((a, b) => b.invoiceId!.compareTo(a.invoiceId!));
  return _invoicesList;
});

final invoiceIndexProvider = StateProvider<InvoiceModel>((ref) => InvoiceModel());