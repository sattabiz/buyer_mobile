String getCurrencySymbol(String currencyCode) {
  switch (currencyCode) {
    case 'TRY':
      return '₺';
    case 'EUR':
      return '€';
    case 'USD':
      return '\$';
    default:
      return currencyCode;
  }
}

Map<int, Map<String, String>> products = {
  0: {
    'name': 'Ürün 1',
    'amount': '1',
    'price': '110',
    'total': '100',
    'taxRate': '20',
    'currencyCode': 'TRY',
  },
  1: {
    'name': 'Ürün 2',
    'amount': '10',
    'price': '110',
    'total': '100',
    'taxRate': '10',
    'currencyCode': 'EUR',
  },
  2: {
    'name': 'Ürün 3',
    'amount': '1',
    'price': '110',
    'total': '100 ',
    'taxRate': '20',
    'currencyCode': 'TRY',
  },
};

Map<String, String> getTotalCost = {
  "Toplam Tutar:": "100",
  "KDV(%20):": "20",
  "Toplam:": "120",
};



List<dynamic> productList = [
  {
      "product_proposal_id": 179,
      "product_files": {},
      "products_proposal_files": {},
      "name": "10",
      "category_id": 1,
      "category_erp_id": null,
      "description": "",
      "amount": 10.0,
      "sended_amount": null,
      "unit": "Adet",
      "price": 10.0,
      "tax_rate": 20,
      "currency_code": "TRY",
      "proposal_note": null
  },
  {
      "product_proposal_id": 179,
      "product_files": {},
      "products_proposal_files": {},
      "name": "10",
      "category_id": 1,
      "category_erp_id": null,
      "description": "",
      "amount": 20.0,
      "sended_amount": null,
      "unit": "Adet",
      "price": 20.0,
      "tax_rate": 20,
      "currency_code": "TRY",
      "proposal_note": null
  }
];



Map<String, String> calculateTaxRate(List<dynamic> productList) {
  Map<String, double> taxRateMap = {};
  Map<String, String> getTotalCost = {};
  late double total;
  late double taxRate;
  late double totalWithoutTax;
  late double totalPrice;
  totalPrice = 0.0;
  totalWithoutTax = 0.0;
  String currencyCode = "empty";

  for (var product in productList) {
    total = (product.price ?? 1) *
        product.amount; //calculate total price only one product
    totalWithoutTax += total; //calculate total price without tax
    taxRate = product.taxRate;

    if (product.currencyCode != null && currencyCode == "empty") {
      currencyCode = product.currencyCode.toString();
    }

    if (taxRateMap.containsKey(taxRate)) {
      taxRateMap[taxRate.toString()] =
          taxRateMap[taxRate]! + (total * taxRate / 100); //calculate tax rate
    } else {
      taxRateMap[taxRate.toString()] = (total * taxRate / 100);
    }
  }

  taxRateMap.forEach((key, value) {
    totalPrice += value; //calculate total price with tax
  });

  taxRateMap["totalWithoutTax"] =
      totalWithoutTax; //calculate total price without tax
  taxRateMap["total"] =
      totalPrice + totalWithoutTax; //calculate total price with tax

  getTotalCost["Toplam Tutar:"] =
      '${taxRateMap["totalWithoutTax"].toString()} ${getCurrencySymbol(currencyCode)}';
  for (var product in productList) {
    getTotalCost["KDV(%${product.taxRate}):"] =
        '${taxRateMap[product.taxRate.toString()].toString()} ${getCurrencySymbol(currencyCode)}';
  }
  getTotalCost["Toplam:"] =
      '${taxRateMap["total"].toString()} ${getCurrencySymbol(currencyCode)}';

  return getTotalCost;
}
