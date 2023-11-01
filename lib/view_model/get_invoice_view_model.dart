import 'package:dio/dio.dart';
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
    response = await apiService.get(url: ApiUrls.invoices);
  } catch (e) {
    rethrow;
  }

  List<InvoiceModel> _invoicesList = [];
  if (response.data['invoices'] != null) {
    _invoicesList = (response.data['invoices'] as List)
        .map((e) => InvoiceModel.fromMap(e))
        .toList();
  }

  _invoicesList.sort((a, b) => b.invoiceId!.compareTo(a.invoiceId!));
  return _invoicesList;
});

final invoiceIndexProvider = StateProvider<InvoiceModel>((ref) => InvoiceModel());