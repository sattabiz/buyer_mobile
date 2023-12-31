import 'dart:convert';

class ShipmentModel {
    int? shipmentId;
    String? invoiceNo;
    int? readyShipmentOrderId;
    String? invoiceDate;
    String? waybillNo;
    DateTime? shipmentDate;
    String? carrier;
    String? trackingNo;
    String? state;
    String? customerName;
    int? proposalId;
    String? address;
    String? orderDate;
    dynamic paymentType;
    int? paymentDueDate;
    String? deliveryDate;
    bool? includeShipmentCost;
    bool? notification;
    bool? messageNotification;
    bool? messageAppNotification = false;
    List<Product>? products;

    ShipmentModel({
        this.shipmentId,
        this.invoiceNo,
        this.readyShipmentOrderId,
        this.invoiceDate,
        this.waybillNo,
        this.shipmentDate,
        this.carrier,
        this.trackingNo,
        this.state,
        this.customerName,
        this.proposalId,
        this.address,
        this.orderDate,
        this.paymentType,
        this.paymentDueDate,
        this.deliveryDate,
        this.includeShipmentCost,
        this.notification,
        this.messageNotification,
        this.messageAppNotification,
        this.products,
    });

    factory ShipmentModel.fromJson(String str) => ShipmentModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ShipmentModel.fromMap(Map<String, dynamic> json) => ShipmentModel(
        shipmentId: json["shipment_id"],
        invoiceNo: json["invoice_no"],
        readyShipmentOrderId: json["ready_shipment_order_id"],
        invoiceDate: json["invoice_date"],
        waybillNo: json["waybill_no"],
        shipmentDate: json["shipment_date"] == null ? null : DateTime.parse(json["shipment_date"]),
        carrier: json["carrier"],
        trackingNo: json["tracking_no"],
        state: json["state"],
        customerName: json["customer_name"],
        proposalId: json["proposal_id"],
        address: json["address"],
        orderDate: json["order_date"],
        paymentType: json["payment_type"],
        paymentDueDate: json["payment_due_date"],
        deliveryDate: json["delivery_date"],
        includeShipmentCost: json["include_shipment_cost"],
        notification: json["notification"],
        messageNotification: json["message_notification"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "shipment_id": shipmentId,
        "invoice_no": invoiceNo,
        "invoice_date": invoiceDate,
        "waybill_no": waybillNo,
        "shipment_date": "${shipmentDate!.year.toString().padLeft(4, '0')}-${shipmentDate!.month.toString().padLeft(2, '0')}-${shipmentDate!.day.toString().padLeft(2, '0')}",
        "carrier": carrier,
        "tracking_no": trackingNo,
        "state": state,
        "customer_name": customerName,
        "proposal_id": proposalId,
        "address": address,
        "order_date": orderDate,
        "payment_type": paymentType,
        "payment_due_date": paymentDueDate,
        "delivery_date": deliveryDate,
        "include_shipment_cost": includeShipmentCost,
        "notification": notification,
        "message_notification": messageNotification,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toMap())),
    };

    @override
    String toString() {
      return 'ProductProposal(shipmentId: $shipmentId, invoiceNo: $invoiceNo, invoiceDate: $invoiceDate, waybillNo: $waybillNo, shipmentDate: $shipmentDate, carrier: $carrier, trackingNo: $trackingNo, state: $state, customerName: $customerName, proposalId: $proposalId, address: $address, orderDate: $orderDate, paymentType: $paymentType, paymentDueDate: $paymentDueDate, deliveryDate: $deliveryDate, includeShipmentCost: $includeShipmentCost, notification: $notification, messageNotification: $messageNotification )';
  }
}

class Product {
    int? orderId;
    int? productsProposalId;
    int? productsProposalShipmentId;
    Map? productFiles;
    Map? productsProposalFiles;
    String? name;
    int? categoryId;
    String? description;
    double? shippedAmount;
    double? invoiceAmount; // it's not read from response
    String? unit;
    double? price;
    int? taxRate;
    String? currencyCode;
    String? proposalNote;
    bool? checkbox; // it' s not read from response

    Product({
        this.orderId,
        this.productsProposalId,
        this.productsProposalShipmentId,
        this.productFiles,
        this.productsProposalFiles,
        this.name,
        this.categoryId,
        this.description,
        this.shippedAmount,
        this.invoiceAmount,
        this.unit,
        this.price,
        this.taxRate,
        this.currencyCode,
        this.proposalNote,
        this.checkbox
    });

    Product copyWith({bool? checkbox, double? invoiceAmount, int? productsProposalShipmentId}) {
    return Product(
      checkbox: checkbox,
      invoiceAmount: invoiceAmount,
      productsProposalShipmentId: productsProposalShipmentId

    );
  }

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        orderId: json["order_id"],
        productsProposalId: json["products_proposal_id"],
        productsProposalShipmentId: json["products_proposal_shipment_id"],
        productFiles: json["product_files"],
        productsProposalFiles: json['products_proposal_files'],
        name: json["name"],
        categoryId: json["category_id"],
        description: json["description"],
        shippedAmount: json["shipped_amount"],
        invoiceAmount: json["shipped_amount"],
        unit: json["unit"],
        price: json["price"],
        taxRate: json["tax_rate"],
        currencyCode: json["currency_code"],
        proposalNote: json["proposal_note"],
        checkbox: false
    );

    Map<String, dynamic> toMap() => {
        "order_id": orderId,
        "products_proposal_id": productsProposalId,
        "products_proposal_shipment_id": productsProposalShipmentId,
        "name": name,
        "category_id": categoryId,
        "description": description,
        "shipped_amount": shippedAmount,
        "unit": unit,
        "price": price,
        "tax_rate": taxRate,
        "currency_code": currencyCode,
        "proposal_note": proposalNote,
    };
    @override
  String toString() {
    return 'ProductProposal(orderId: $orderId, productsProposalId: $productsProposalId, productsProposalShipmentId: $productsProposalShipmentId, productFiles: $productFiles, productsProposalFiles: $productsProposalFiles, name: $name, categoryId: $categoryId, description: $description, invoiceAmount:$invoiceAmount, shippedAmount: $shippedAmount, unit: $unit, price: $price, taxRate: $taxRate, currencyCode: $currencyCode, proposalNote: $proposalNote, checkbox:$checkbox )';
  }
}


