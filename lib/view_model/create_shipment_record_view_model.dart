import 'package:buyer_mobile/view_model/get_order_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/api_url.dart';
import '../service/post_service.dart';
import '../view/order_view/ready_for_ship_detail.dart';

final createShipmentPostProvider = FutureProvider.autoDispose((
  ref,
) async {
  final apiService = PostService();
  Response response;

  List<ProductProposalsModel> productList = ref.watch(createShipmentFormProvider);
  int? orderId = ref.watch(createShipmentOrderIdProvider);

  Map<String, dynamic> _productsAttributes = {};


  for (int i = 0; i < productList.length; i++) {
    _productsAttributes['$i'] = {
      "products_proposal_id": productList[i].productsProposalId.toString(),
      "ready_amount": productList[i].readyAmount.toString(),
    };
  }
  Map<String, dynamic> data = {
    "order_id": orderId,
    "products_proposals": _productsAttributes
  };

  debugPrint(data.toString());
  debugPrint('create shipment service');
  debugPrint(orderId.toString());
 

   try {
    debugPrint("--------------------------------------------");
     response = await apiService.post(url: ApiUrls.createShipment,  data: data ); 
      debugPrint(response.toString());
      await ref.refresh(getOrderProvider);
      ref.read(getOrderProvider.future);
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        //ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }

  //return response; 
});