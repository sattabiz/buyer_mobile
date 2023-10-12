
import 'package:buyer_mobile/view_model/get_invoice_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/api_url.dart';
import '../service/post_service.dart';

final invoicePaidProvider = FutureProvider.autoDispose((ref) async {
  final apiService = PostService();
  Response response;
  /* final proposalProviderAsyncValue =
       ref.watch(getProposalListProvider).value;
  final proposalIdValue = ref.watch(proposalIndexProvider);
  //debugPrint('product proposal id value${proposalIdValue}');
  Map<String, dynamic> _productsAttributes = {};
  if(proposalProviderAsyncValue![proposalIdValue!] != null) {
      _productsAttributes['0'] = {
        "proposal_id": proposalProviderAsyncValue[proposalIdValue].proposalId.toString(),
        "product_proposal_ids": proposalProviderAsyncValue[proposalIdValue]
            .productProposals!
            .map((product) => product.productProposalId)
            .toList()
      };
  } */
  Map<String, dynamic> _productsAttributes = {
    "invoice_id":ref.watch(invoiceIdProvider)
  };
  debugPrint(ref.watch(invoiceIdProvider).toString());
  debugPrint(_productsAttributes.toString());
  try {
    response = await apiService.post(url: ApiUrls.invoicesPaid, data: _productsAttributes);
     await ref.refresh(getInvoicesProvider);
     ref.read(getInvoicesProvider.future); 
  } catch (e) {
    if (e is DioException) {

    }
    rethrow;
  }
  debugPrint(response.toString());

  return response.statusCode;
});


final invoiceIdProvider = StateProvider<int?>((ref) => 0);   //read orderId for confirm order post service