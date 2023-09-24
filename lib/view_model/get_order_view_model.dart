import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/api_url.dart';
import '../model/order_model.dart';
import '../service/get_services.dart';

final getOrderProvider =
    FutureProvider.autoDispose<List<OrderModel>>((ref) async {
  final apiService = ApiService();
  Response response;
  try {
    response = await apiService.get(url: ApiUrls.orders);
    debugPrint(response.data.toString());
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }
  List<OrderModel> _orderList = [];
  if (response.data['order'] != null) {
    _orderList = (response.data['order'] as List)
        .map((e) => OrderModel.fromMap(e))
        .toList();
  }
 
 debugPrint(response.data.toString());
 /* for (int i = 0; i <= _orderList.length; i++) {
    debugPrint(
        '--------------------------------------------------------------------------------------------------------------------------------------------------------------');
    debugPrint(_orderList[i].toString());
  } */
  _orderList.sort((a, b) => b.id!.compareTo(a.id!));
  return _orderList;
});

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});