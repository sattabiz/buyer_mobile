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

  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        print('${e.response?.statusCode}');
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

  _orderList.sort((a, b) => b.id!.compareTo(a.id!));
  return _orderList;
});

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});

final orderIndexProvider = StateProvider<OrderModel?>((ref) => OrderModel());
