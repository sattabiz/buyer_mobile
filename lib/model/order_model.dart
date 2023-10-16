import 'dart:convert';

class OrderModel {
  int? id;
  int? proposalId;
  String? sellerUserName;
  int? companyId;
  String? customerCompanyName;
  String? state;
  String? deliveryDate;
  int? paymentDueDate;
  String? paymentType;
  bool? includeShipmentCost;
  String? orderDate;
  bool? notification;
  bool? messageNotification;
  bool? messageAppNotification = false;
  List<Product>? products;

  OrderModel({
    this.id,
    this.proposalId,
    this.sellerUserName,
    this.companyId,
    this.customerCompanyName,
    this.state,
    this.deliveryDate,
    this.paymentDueDate,
    this.paymentType,
    this.includeShipmentCost,
    this.orderDate,
    this.notification,
    this.messageNotification,
    this.messageAppNotification,
    this.products,
  });

  factory OrderModel.fromJson(String str) =>
      OrderModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        proposalId: json["proposal_id"],
        sellerUserName: json["seller_user_name"],
        companyId: json["company_id"],
        customerCompanyName: json["customer_company_name"],
        state: json["state"],
        deliveryDate: json["delivery_date"],
        paymentDueDate: json["payment_due_date"],
        paymentType: json["payment_type"],
        includeShipmentCost: json["include_shipment_cost"],
        orderDate: json["order_date"],
        notification: json["notification"],
        messageNotification: json["message_notification"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "proposal_id": proposalId,
        "seller_user_name": sellerUserName,
        "company_id": companyId,
        "customer_company_name": customerCompanyName,
        "state": state,
        "delivery_date": deliveryDate,
        "payment_due_date": paymentDueDate,
        "payment_type": paymentType,
        "include_shipment_cost": includeShipmentCost,
        "order_date": orderDate,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toMap())),
      };
}

class Product {
  int? orderId;
  int? productProposalId;
  Map? productFiles;
  Map? productsProposalFiles;
  String? name;
  int? categoryId;
  String? categoryErpId;
  String? description;
  double? amount;
  double? sendedAmount;
  String? unit;
  double? price;
  int? taxRate;
  String? currencyCode;
  String? proposalNote;

  Product({
    this.orderId,
    this.productProposalId,
    this.productFiles,
    this.productsProposalFiles,
    this.name,
    this.categoryId,
    this.categoryErpId,
    this.description,
    this.amount,
    this.sendedAmount,
    this.unit,
    this.price,
    this.taxRate,
    this.currencyCode,
    this.proposalNote,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        orderId: json["order_id"],
        productProposalId: json["products_proposal_id"],
        productFiles: json['products_proposal_files'],
        productsProposalFiles: json['products_proposal_files'],
        name: json["name"],
        categoryId: json["category_id"],
        categoryErpId: json["category_erp_id"],
        description: json["description"],
        amount: json["amount"],
        sendedAmount: json["sended_amount"],
        unit: json["unit"],
        price: json["price"],
        taxRate: json["tax_rate"],
        currencyCode: json["currency_code"],
        proposalNote: json["proposal_note"],
      );

  Map<String, dynamic> toMap() => {
        "product_proposal_id": productProposalId,
        "name": name,
        "category_id": categoryId,
        "category_erp_id": categoryErpId,
        "description": description,
        "amount": amount,
        "sended_amount": sendedAmount,
        "unit": unit,
        "price": price,
        "tax_rate": taxRate,
        "currency_code": currencyCode,
        "proposal_note": proposalNote,
      };
  @override
  String toString() {
    return 'Product{productProposalId: $productProposalId, name: $name, categoryId: $categoryId, categoryErpId: $categoryErpId, description: $description, amount: $amount, taxRate: $taxRate, unit: $unit, price: $price, currencyCode: $currencyCode, proposalNote: $proposalNote, productsProposalFiles: $productsProposalFiles}';
  }
}
