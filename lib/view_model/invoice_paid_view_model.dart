
import 'package:PaletPoint/view_model/get_invoice_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/api_url.dart';
import '../service/post_service.dart';

final invoicePaidProvider = FutureProvider.autoDispose((ref) async {
  final apiService = PostService();
  Response response;

  Map<String, dynamic> _productsAttributes = {
    "invoice_id":ref.watch(invoiceIdProvider)
  };

  try {
    response = await apiService.post(url: ApiUrls.invoicesPaid, data: _productsAttributes);
     await ref.refresh(getInvoicesProvider);
     ref.read(getInvoicesProvider.future); 
  } catch (e) {
    if (e is DioException) {

    }
    rethrow;
  }


  return response.statusCode;
});


final invoiceIdProvider = StateProvider<int?>((ref) => 0);   //read orderId for confirm order post service