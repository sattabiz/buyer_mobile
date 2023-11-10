import 'package:PaletPoint/view_model/get_order_view_model.dart';
import 'package:PaletPoint/view_model/get_shipment_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/api_url.dart';
import '../../model/shipment_model.dart';
import '../../service/post_service.dart';
import '../../view/invoice_view/generate_invoice.dart';
import '../get_invoice_view_model.dart';
import 'multi_order_invoice_view_model.dart';

final createMultiOrderInvoiceProvider = FutureProvider.autoDispose((ref,) async {

  
  final apiService = PostService();
  Response response;
  List<Product> _formItems = await ref.watch(multiOrderProvider);
   InvoiceTable _contentItems = await ref.watch(invoiceTableProvider);

  Map<String, dynamic> _productsAttributes = {};


  
  for (int i = 0; i < _formItems.length; i++) {
      _productsAttributes["${_formItems[i].productsProposalShipmentId}"] = _formItems[i].invoiceAmount;
   
  }

  Map<String, dynamic> data = {
    "invoice_no": _contentItems.invoiceNo.toString(),
    "invoice_date": _contentItems.invoiceDate.toString(),
    "shipment_date": _contentItems.shipmentDate.toString(),
    "waybill_no": _contentItems.waybillNo.toString(),
    "contact_information_id": _contentItems.contactInformationId!.id,
    "carrier": _contentItems.carrier.toString(),
    "tracking": _contentItems.tracking.toString(),
    "products_proposal_shipments": _productsAttributes
  };

 

   try {
    response = await apiService.post(url: ApiUrls.createMultiOrderInvoice, data: data); 
    await ref.refresh(getShipmentProvider);
    ref.read(getShipmentProvider.future);
    await ref.refresh(getOrderProvider);
    ref.read(getOrderProvider.future);
    await ref.refresh(getInvoicesProvider);
    ref.read(getInvoicesProvider);
  } catch (e) {
    rethrow;
  }

  return response; 
});