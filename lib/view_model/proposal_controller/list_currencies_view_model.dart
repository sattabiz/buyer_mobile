import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/api_url.dart';
import '../../model/proposal_model.dart';
import '../../service/get_services.dart';

final getListCurrenciesProvider =
    FutureProvider((ref) async {
  final apiService = ApiService();

  Response response;

  try {
    response = await apiService.get(url: ApiUrls.currencies);
  
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {}
    }
    rethrow;
  }
  
 
  

  Map<dynamic, dynamic> jsonResponse = jsonDecode(response.data["currencies"]);


});

