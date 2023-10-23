import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/api_url.dart';
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

  /* currencyModels.forEach((model) {
    print('Model: ${model.toString()}');
  }); */
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

class CurrencyModel {
  String name;
  String code;
  String symbol;
  String source;
  bool active;

  CurrencyModel({
    required this.name,
    required this.code,
    required this.symbol,
    required this.source,
    required this.active,
  });

  factory CurrencyModel.fromJson(String key, Map<String, dynamic> json) {
    return CurrencyModel(
      name: json['name'],
      code: json['code'],
      symbol: json['symbol'],
      source: json['source'],
      active: json['active'],
    );
  }

  @override
  String toString() {
    return 'CurrencyModel{name: $name, code: $code, symbol: $symbol, source: $source, active: $active}';
  }
}
