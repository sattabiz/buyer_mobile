import 'package:dio/dio.dart';
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
      rethrow;
    }
    rethrow;
  }



  List<dynamic> notificationList = [];


  List<ProposalModel> _proposalList = [];
  if (response.data['proposals'] != null) {
    _proposalList = (response.data['proposals'] as List)
        .map((e) => ProposalModel.fromMap(e))
        .toList();
    for(ProposalModel _proposalMessage in _proposalList){
      _proposalMessage.messageAppNotification = false;
    }
    notificationList.addAll(_proposalList);

  }

  List<OrderModel> _orderList = [];
  if (response.data['orders'] != null) {
    _orderList = (response.data['orders'] as List)
        .map((e) => OrderModel.fromMap(e))
        .toList();
    for(OrderModel _orderMessage in _orderList){
      _orderMessage.messageAppNotification = false;
    }
    notificationList.addAll(_orderList);
  }
  List<ProposalModel> _proposalMessageList = [];
  if (response.data['message_proposals'] != null) {
    _proposalMessageList = (response.data['message_proposals'] as List)
        .map((e) => ProposalModel.fromMap(e))
        .toList();
    for(ProposalModel _proposalMessage in _proposalMessageList){
      _proposalMessage.messageAppNotification = true;
    }
    notificationList.addAll(_proposalMessageList);

  }

  List<OrderModel> _orderMessageList = [];
  if (response.data['message_orders'] != null) {
    _orderMessageList = (response.data['message_orders'] as List)
        .map((e) => OrderModel.fromMap(e))
        .toList();
    for(OrderModel _orderMessage in _orderMessageList){
      _orderMessage.messageAppNotification = true;
    }
    notificationList.addAll(_orderMessageList);
  }



  

  List<ShipmentModel> _shipmentMessageList = [];
  if (response.data['message_shipments'] != null) {
    _shipmentMessageList = (response.data['message_shipments'] as List)
        .map((e) => ShipmentModel.fromMap(e))
        .toList();
    for(ShipmentModel _shipmentMessage in _shipmentMessageList){
      _shipmentMessage.messageAppNotification = true;
    }
    notificationList.addAll(_shipmentMessageList);
  }


  List<InvoiceModel> _invoiceMessageList = [];
  if (response.data['message_invoices'] != null) {
    _invoiceMessageList = (response.data['message_invoices'] as List)
        .map((e) => InvoiceModel.fromMap(e))
        .toList();
    for(InvoiceModel _invoiceMessage in _invoiceMessageList){
      _invoiceMessage.messageAppNotification = true;
    }
    notificationList.addAll(_invoiceMessageList);
  }

 
  return notificationList;


});
