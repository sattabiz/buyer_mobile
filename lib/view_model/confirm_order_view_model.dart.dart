import 'package:PaletPoint/view_model/get_notifications_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_url.dart';
import '../service/post_service.dart';
import 'get_order_view_model.dart';


final confirmOrderProvider = FutureProvider.autoDispose((ref) async {
  final apiService = PostService();
  Response response;

  Map<String, dynamic> _productsAttributes = {
    "order_id":ref.watch(orderIdProvider)
  };
  try {
    response = await apiService.post(url: ApiUrls.confirmOrder, data: _productsAttributes);
     await ref.refresh(getOrderProvider);
            ref.read(getOrderProvider.future); 
     await ref.refresh(getNotificationProvider);
     ref.read(getNotificationProvider.future);
  } catch (e) {
    rethrow;
  }


  return response.statusCode;
});


final orderIdProvider = StateProvider<int?>((ref) => 0);   //read orderId for confirm order post service