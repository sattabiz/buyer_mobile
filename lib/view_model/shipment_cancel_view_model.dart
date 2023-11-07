import 'package:PaletPoint/view_model/get_shipment_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_url.dart';
import '../service/post_service.dart';

final cancelPreparedShipmentController = FutureProvider.autoDispose((ref) async {

  final apiService = PostService();
  Response response;

  String shipmentId = ref.watch(cancelShipmentIdProvider);

  

  try {
    response = await apiService.post(url: ApiUrls.cancelPreparedShipment(shipmentId),);
    ref.refresh(getShipmentProvider);   
  } catch (e) {
    rethrow;
  }



});


final cancelShipmentIdProvider = StateProvider<String>((ref) => "");