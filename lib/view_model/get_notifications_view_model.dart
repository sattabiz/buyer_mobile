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

  try {
    response = await apiService.get(url: ApiUrls.notifications);
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        print('${e.response?.statusCode}');
      }
    }
    rethrow;
  }



  List<dynamic> notificationList = [];


  List<ProposalModel> _proposalList = [];
  if (response.data['proposals'] != null) {
    _proposalList = (response.data['proposals'] as List)
        .map((e) => ProposalModel.fromMap(e))
        .toList();
    notificationList.addAll(_proposalList);
  }

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

  List<OrderModel> _orderMessageList = [];
  if (response.data['message_orders'] != null) {
    _orderMessageList = (response.data['message_orders'] as List)
        .map((e) => OrderModel.fromMap(e))
        .toList();
    notificationList.addAll(_orderMessageList);
  }

  _orderList.addAll(_orderMessageList);

  

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

 
  return notificationList;


});
