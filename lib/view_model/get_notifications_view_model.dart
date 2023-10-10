import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/api_url.dart';
import '../model/invoice_model.dart';
import '../model/order_model.dart';
import '../model/proposal_model.dart';
import '../model/shipment_model.dart';
import '../service/get_services.dart';

final getNotificationProvider =
    FutureProvider.autoDispose<List<dynamic>>((ref) async {
  final apiService = ApiService();
  Response response;
  debugPrint("------------------------------------");
  try {
    response = await apiService.get(url: ApiUrls.notifications);
    debugPrint(response.data.toString());
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        print('${e.response?.statusCode}');
      }
    }
    rethrow;
  }
  debugPrint("-----------------------------");

  //Map<String, dynamic> responseMap = jsonDecode(response.data);
  //Map notificationMap = json.decode(response.data);
  debugPrint("-----------------------------");
  //debugPrint(notificationMap.toString());
  List<dynamic> notificationList = [];

  /* for(var value in notificationMap.entries){
      debugPrint(value.toString());
  } */
  List<ProposalModel> _proposalList = [];
  if (response.data['proposals'] != null) {
    _proposalList = (response.data['proposals'] as List)
        .map((e) => ProposalModel.fromMap(e))
        .toList();
    notificationList.addAll(_proposalList);
  }
  debugPrint(_proposalList.toString());
  List<OrderModel> _orderList = [];
  if (response.data['orders'] != null) {
    _orderList = (response.data['orders'] as List)
        .map((e) => OrderModel.fromMap(e))
        .toList();
    notificationList.addAll(_orderList);
  }
  List<ProposalModel> _proposalMessageList = [];
  if (response.data['message_proposals'] != null) {
    _proposalMessageList = (response.data['message_proposals'] as List)
        .map((e) => ProposalModel.fromMap(e))
        .toList();
    notificationList.addAll(_proposalMessageList);

  }
  debugPrint(notificationList.toString());  

  debugPrint("----------------------------s");

  debugPrint(_orderList.toString()); 
  List<OrderModel> _orderMessageList = [];
  if (response.data['message_orders'] != null) {
    _orderMessageList = (response.data['message_orders'] as List)
        .map((e) => OrderModel.fromMap(e))
        .toList();
    notificationList.addAll(_orderMessageList);
  }

  _orderList.addAll(_orderMessageList);

  debugPrint(_orderList.toString());

  //debugPrint(_orderMessageList.toString());    

  List<ShipmentModel> _shipmentMessageList = [];
  if (response.data['message_shipments'] != null) {
    _shipmentMessageList = (response.data['message_shipments'] as List)
        .map((e) => ShipmentModel.fromMap(e))
        .toList();
    notificationList.addAll(_shipmentMessageList);
  }


  List<InvoiceModel> _invoicesMessageList = [];
  if (response.data['message_invoices'] != null) {
    _invoicesMessageList = (response.data['message_invoices'] as List)
        .map((e) => InvoiceModel.fromMap(e))
        .toList();
    notificationList.addAll(_invoicesMessageList);
  }

  debugPrint("----------------------------last");
  debugPrint(notificationList.toString());
  return notificationList;

  /* List<OrderModel> _orderList = [];
  if (response.data['order'] != null) {
    _orderList = (response.data['order'] as List)
        .map((e) => OrderModel.fromMap(e))
        .toList();
  } */

  //debugPrint(response.data.toString());
  /* for (int i = 0; i <= _orderList.length; i++) {
    debugPrint(
        '--------------------------------------------------------------------------------------------------------------------------------------------------------------');
    debugPrint(_orderList[i].toString());
  } */
  /* _orderList.sort((a, b) => b.id!.compareTo(a.id!));
  return _orderList; */
});
