Map<String, String> statusIconMap = {
  'pending': 'assets/svg/alert_error.svg',
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

List<String> CITY_LIST = [
  'Adana',
  'Adıyaman',
  'Afyon',
  'Ağrı',
  'Aksaray',
  'Amasya',
  'Ankara',
  'Antalya',
  'Ardahan',
  'Artvin',
  'Aydın',
  'Balıkesir',
  'Bartın',
  'Batman',
  'Bayburt',
  'Bilecik',
  'Bingöl',
  'Bitlis',
  'Bolu',
  'Burdur',
  'Bursa',
  'Çanakkale',
  'Çankırı',
  'Çorum',
  'Denizli',
  'Diyarbakır',
  'Düzce',
  'Edirne',
  'Elazığ',
  'Erzincan',
  'Erzurum',
  'Eskişehir',
  'Gaziantep',
  'Giresun',
  'Gümüşhane',
  'Hakkari',
  'Hatay',
  'Iğdır',
  'Isparta',
  'İstanbul',
  'İzmir',
  'Kahramanmaraş',
  'Karabük',
  'Karaman',
  'Kars',
  'Kastamonu',
  'Kayseri',
  'Kırıkkale',
  'Kırklareli',
  'Kırşehir',
  'Kilis',
  'Kocaeli',
  'Konya',
  'Kütahya',
  'Malatya',
  'Manisa',
  'Mardin',
  'Mersin',
  'Muğla',
  'Muş',
  'Nevşehir',
  'Niğde',
  'Ordu',
  'Osmaniye',
  'Rize',
  'Sakarya',
  'Samsun',
  'Siirt',
  'Sinop',
  'Sivas',
  'Şanlıurfa',
  'Şırnak',
  'Tekirdağ',
  'Tokat',
  'Trabzon',
  'Tunceli',
  'Uşak',
  'Van',
  'Yalova',
  'Yozgat',
  'Zonguldak'
];

String formattedDate(String date) {
  if (date == 'null') {
    return '-';
  } else {
    final DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.year.toString().padLeft(2, '0')}";
  }
}

DateTime dateForCount(String date) {
  if (date == 'null') {
    return  DateTime.now();
  } else {
    final DateTime parsedDate = DateTime.parse(date);
    return parsedDate;
    // return Duration(
    //   days: parsedDate.day,
    //   hours: parsedDate.hour,
    //   minutes: parsedDate.minute,
    //   seconds: parsedDate.second,
    // );
    // return "${parsedDate.day} G ${parsedDate.hour.toString().padLeft(2, '0')}-${parsedDate.minute.toString().padLeft(2, '0')}";
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
      return '₺';
  }
}

int getCurrencyValue(String currencyCode) {
  switch (currencyCode) {
    case 'TRY':
      return 0;
    case 'EUR':
      return 2;
    case 'USD':
      return 1;
    case 'GBP':
      return 3;
    default:
      return 0;
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
