import 'dart:async';

import 'package:buyer_mobile/view_model/get_shipment_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../config/api_url.dart';
import '../../model/shipment_model.dart';
import '../../service/post_service.dart';
import '../../view/invoice_view/generate_invoice.dart';
import '../proposal_controller/create_proposal_view_model.dart';
import 'multi_order_invoice_view_model.dart';

final createMultiOrderInvoiceProvider = FutureProvider.autoDispose((
  ref,
) async {
  final apiService = PostService();
  Response response;
  List<Product> _formItems = await ref.watch(multiOrderProvider);
   InvoiceTable _contentItems = await ref.watch(invoiceTableProvider);

  Map<String, dynamic> _productsAttributes = {};

  /* for (int i = 0; i < _formItems.length; i++) {
    debugPrint(_formItems[i].productId.toString());
    debugPrint(_formItems[i].note.toString());
    debugPrint(_formItems[i].price.toString());
    debugPrint(_formItems.length.toString());
  } */
  
  for (int i = 0; i < _formItems.length; i++) {
      _productsAttributes["${_formItems[i].productsProposalShipmentId}"] = _formItems[i].invoiceAmount.toString();
   
  }

  Map<String, dynamic> data = {
    "invoice_no": _contentItems.invoiceNo,
    "invoice_date": _contentItems.invoiceDate,
    "shipment_date": _contentItems.shipmentDate,
    "waybill_no": _contentItems.waybillNo,
    "contact_information_id": _contentItems.contactInformationId,
    "carrier": _contentItems.carrier,
    "tracking": _contentItems.tracking,
    "products_proposal_shipments": _productsAttributes
  };
  debugPrint('datanin ustu');
  debugPrint(data.toString());

 

   try {
    debugPrint("--------------------------------------------");
     response = await apiService.post(url: ApiUrls.createMultiOrderInvoice, data: data); 
      debugPrint(response.toString());
    await ref.refresh(getShipmentProvider);
    ref.read(getShipmentProvider.future);
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