import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_url.dart';
import '../model/invoice_model.dart';
import '../service/get_services.dart';

final getInvoicesProvider = FutureProvider.autoDispose<List<InvoiceModel>>((ref) async {
  final apiService = ApiService();
  Response response;
  try {
    response = await apiService.get(url: ApiUrls.invoices);
  } catch (e) {
    rethrow;
  }

  List<InvoiceModel> _invoicesList = [];
  if (response.data['invoices'] != null) {
    _invoicesList = (response.data['invoices'] as List)
        .map((e) => InvoiceModel.fromMap(e))
        .toList();
  }

  _invoicesList.sort((a, b) => b.invoiceId!.compareTo(a.invoiceId!));
  return _invoicesList;
});

final invoiceIndexProvider = StateProvider<InvoiceModel>((ref) {
  return InvoiceModel();
},);

final invoiceCurrenciesIndexProvider = StateProvider<String?>((ref) {
  InvoiceModel invoice = ref.watch(invoiceIndexProvider);
  List<Product> products = invoice.products!;
  List<String> currencies = [];
  for(Product product in products){
    if(product.currencyCode != "TRY"){
      if(product.currencyCode == "USD"){
        currencies.add("USD(\$)= ${invoice.foreignCurrencies?['1']}");
      }else if(product.currencyCode == "EUR"){
        currencies.add("Euro(€)= ${invoice.foreignCurrencies?['2']}");
      }else{
        currencies.add("GBP(£)= ${invoice.foreignCurrencies?['3']}");
      }
    }
  }
  currencies = currencies.toSet().toList();                  //It helps to deduplicate multiple occurrences of the same data.   
  if(currencies.isNotEmpty){                                 //Check of the if block above
    String currenciesValue = currencies.join(", ");          //It serves to convert the List<String> currencies into a string
    String currenciesMessage = "${invoice.invoiceDate.toString().split('T')[0]} itibari ile TCMB satış kuru; $currenciesValue";
    return currenciesMessage;
  }else{
    return "";
  } 
},);