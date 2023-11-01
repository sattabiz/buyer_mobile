import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/api_url.dart';
import '../../model/currency_model.dart';
import '../../service/get_services.dart';

final getListCurrenciesProvider = FutureProvider((ref) async {
  final apiService = ApiService();
  Response response;

  try {
    response = await apiService.get(url: ApiUrls.currencies);
  } catch (e) {
    if (e is DioException) {
      rethrow;
    }
    rethrow;
  }

  Map<String, dynamic> data = jsonDecode(response.toString());
  
  Map<String, dynamic> jsonResponse = data["currencies"];
  
  List<CurrencyModel> currencyModelList = [];
  jsonResponse.forEach((key, value) {
    var currencyModel = CurrencyModel.fromJson(key, value);
    currencyModelList.add(currencyModel);
  });

  if (currencyModelList == []) {
    CurrencyModel currency = CurrencyModel(
      name: 'Türk Lirası',
      code: 'TRY',
      symbol: '₺',
      source: 'TCMB',
      active: true,
    );

    ref.read(currenciesProvider.notifier).state = [currency];

  }else{
    ref.read(currenciesProvider.notifier).state = currencyModelList;
  }
  return currencyModelList;
});

final currenciesProvider = StateProvider<List<CurrencyModel>>(
  (ref) {
    return [];
  },
);
