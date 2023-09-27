import 'package:buyer_mobile/model/shipment_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/api_url.dart';
import '../service/get_services.dart';
import 'get_order_view_model.dart';

final getShipmentProvider =
    FutureProvider.autoDispose<List<ShipmentModel>>((ref) async {
  final apiService = ApiService();
  Response response;
  try {
    response = await apiService.get(url: ApiUrls.shipment);
    debugPrint(response.data.toString());
  } catch (error) {
    if (error is DioException) {
      if (error.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }
  //debugPrint('_invoicesList[0].products![0].categoryId.toString()');
  List<ShipmentModel> _shipmentList = [];
  if (response.data['shipments'] != null) {
    _shipmentList = (response.data['shipments'] as List)
        .map((e) => ShipmentModel.fromMap(e))
        .toList();
  }
  /* debugPrint('sadasfffasddsadsdsaas');
  debugPrint(_invoicesList[1].products![0].categoryId.toString()); */
  _shipmentList.sort((a, b) => b.shipmentId!.compareTo(a.shipmentId!));
  return _shipmentList;
});
