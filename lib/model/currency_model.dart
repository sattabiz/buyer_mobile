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
