import 'dart:convert';

class InvoiceModel {
  int? invoiceId;
  String? invoiceNo;
  int? orderId;
  String? invoiceDate;
  String? paymentDate;
  dynamic paymentType;
  String? state;
  dynamic note;
  bool? dbs;
  String? priceWithoutVat;
  String? totalTlPrice;
  String? buyerName;
  dynamic buyerErpId;
  bool? notification;
  bool? messageNotification;
  bool? messageAppNotification = false;
  List<Product>? products;

  InvoiceModel({
    this.invoiceId,
    this.invoiceNo,
    this.orderId,
    this.invoiceDate,
    this.paymentDate,
    this.paymentType,
    this.state,
    this.note,
    this.dbs,
    this.priceWithoutVat,
    this.totalTlPrice,
    this.buyerName,
    this.buyerErpId,
    this.notification,
    this.messageNotification,
    this.messageAppNotification,
    this.products,
  });

  factory InvoiceModel.fromJson(String str) =>
      InvoiceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromMap(Map<String, dynamic> json) => InvoiceModel(
        invoiceId: json["invoice_id"],
        invoiceNo: json["invoice_no"],
        orderId: json["order_id"],
        invoiceDate: json["invoice_date"],
        paymentDate: json["payment_date"],
        paymentType: json["payment_type"],
        state: json["state"],
        note: json["note"],
        dbs: json["dbs"],
        priceWithoutVat: json["price_without_vat"],
        totalTlPrice: json["total_tl_price"],
        buyerName: json["buyer_name"],
        buyerErpId: json["buyer_erp_id"],
        notification: json["notification"],
        messageNotification: json["message_notification"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "invoice_id": invoiceId,
        "invoice_no": invoiceNo,
        "order_id": orderId,
        "invoice_date": invoiceDate,
        "payment_date": paymentDate,
        "payment_type": paymentType,
        "state": state,
        "note": note,
        "dbs": dbs,
        "price_without_vat": priceWithoutVat,
        "total_tl_price": totalTlPrice,
        "buyer_name": buyerName,
        "buyer_erp_id": buyerErpId,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toMap())),
      };
}

class Product {
  int? productsProposalId;
  Map? productFiles;
  Map? productsProposalFiles;
  String? name;
  int? categoryId;
  String? description;
  double? amount;
  int? taxRate;
  String? unit;
  double? price;
  String? currencyCode;
  dynamic proposalNote;

  Product({
    this.productsProposalId,
    this.productFiles,
    this.productsProposalFiles,
    this.name,
    this.categoryId,
    this.description,
    this.amount,
    this.taxRate,
    this.unit,
    this.price,
    this.currencyCode,
    this.proposalNote,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        productsProposalId: json["products_proposal_id"],
        productFiles: json['products_proposal_files'],
        productsProposalFiles: json['products_proposal_files'],
        name: json["name"],
        categoryId: json["category_id"],
        description: json["description"],
        amount: json["shipped_amount"],
        taxRate: json["tax_rate"],
        unit: json["unit"],
        price: json["price"],
        currencyCode: json["currency_code"],
        proposalNote: json["proposal_note"],
      );

  Map<String, dynamic> toMap() => {
        "products_proposal_id": productsProposalId,
        "name": name,
        "category_id": categoryId,
        "description": description,
        "shipped_amount": amount,
        "tax_rate": taxRate,
        "unit": unit,
        "price": price,
        "currency_code": currencyCode,
        "proposal_note": proposalNote,
      };
  @override
  @override
  String toString() {
    return 'Product{productProposalId: $productsProposalId, name: $name, categoryId: $categoryId, description: $description, unit: $unit, price: $price, currencyCode: $currencyCode, proposalNote: $proposalNote, productsProposalFiles: $productsProposalFiles}';
  }
}
