Map<String, String> statusIconMap = {
  'pending': 'assets/svg/alert.svg',
  'replied': 'assets/svg/proposalReplied.svg', //degisecek
  'proposal_stvs': 'assets/svg/vector.svg', //degisecek
  'last_offer': 'assets/svg/vector.svg',
  'order_approved': 'assets/svg/flare.svg',
  'order_confirmed': 'assets/svg/conveyor.svg',
  'order_prepared': 'assets/svg/trolley.svg',
  'order_on_the_way': 'assets/svg/truck.svg',
  'order_delivered': 'assets/svg/warehouse.svg',
  'invoice_sended': 'assets/svg/truck.svg', //yolda
  'invoice_goods_delivered': 'assets/svg/warehouse.svg', //onay bekl;iyor
  'invoice_approved': 'assets/svg/not_secure.svg', //acik fatura
  'invoice_approved_dbs': 'assets/svg/dbs.svg',
  'invoice_collecting': 'assets/svg/payment_process.svg',
  'invoice_discounted': 'assets/svg/paid.svg', //odendi
};

Map<String, String> getTotalCost = {
  "Toplam Tutar:": "100",
  "KDV(%20):": "20",
  "Toplam:": "120",
};

String formattedDate(String date) {
  if (date == 'null') {
    return '-';
  } else {
    final DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.year.toString().padLeft(2, '0')}";
  }
}

String getCurrencySymbol(String currencyCode) {
  switch (currencyCode) {
    case 'TRY':
      return '₺';
    case 'EUR':
      return '€';
    case 'USD':
      return '\$';
    case 'GBP':
      return '£';
    default:
      return currencyCode;
  }
}

String? alertIconWithState(String state) {
  if (state == 'order_approved') {
    return 'assets/svg/alert_error.svg';
  } else {
    return statusIconMap[state];
  }
}

String calcuteAmount(String amount, String price) {
  return (double.parse(amount) * double.parse(price)).toString();
}

Map<String, String> calculateTaxRate(List<dynamic> productList) {
  Map<String, double> taxRateMap = {};
  Map<String, String> getTotalCost = {};
  late double total;
  late int taxRate;
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
