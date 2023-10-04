
import 'package:buyer_mobile/model/address_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/api_url.dart';
import '../service/get_services.dart';

final getAddressFutureProvider =
    FutureProvider.autoDispose<List<AddressModel>>((ref) async {
  final apiService = ApiService();
  Response response;
  try {
    response = await apiService.get(url: ApiUrls.address);
    debugPrint(response.data.toString());
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        print('${e.response?.statusCode}');
      }
    }
    rethrow;
  }
  List<AddressModel> _addressModelList = [];
  if (response.data['addresses'] != null) {
    _addressModelList = (response.data['addresses'] as List)
        .map((e) => AddressModel.fromMap(e))
        .toList();
  }


  debugPrint(_addressModelList.toString());
  return _addressModelList;
});
