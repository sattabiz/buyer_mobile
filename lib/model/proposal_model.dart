import 'dart:convert';

class ProposalModel {
    int? proposalId;
    String? proposalCreatedAt;
    String? proposalUpdatedAt;
    String? proposalState;
    int? proposalValidPeriod;
    int? proposalDeliveryTime;
    String? proposalValidDate;
    bool? includeShipmentCost;
    int? paymentDueDate;
    String? deliveryDate;
    String? customerCompany;
    int? customerCompanyId;
    String? sellerUserName;
    String? paymentType;
    int? updateCounter;
    bool? notification;
    bool? messageNotification;
    String? demandListName;
    bool? messageAppNotification = false;
    List<ProductProposal>? productProposals;

    ProposalModel({
        this.proposalId,
        this.proposalCreatedAt,
        this.proposalUpdatedAt,
        this.proposalState,
        this.proposalValidPeriod,
        this.proposalDeliveryTime,
        this.proposalValidDate,
        this.includeShipmentCost,
        this.paymentDueDate,
        this.deliveryDate,
        this.customerCompany,
        this.customerCompanyId,
        this.sellerUserName,
        this.paymentType,
        this.updateCounter,
        this.notification,
        this.messageNotification,
        this.demandListName,
        this.messageAppNotification,
        this.productProposals,
    });

    factory ProposalModel.fromJson(String str) => ProposalModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProposalModel.fromMap(Map<String, dynamic> json) => ProposalModel(
        proposalId: json["proposal_id"],
        proposalCreatedAt: json["proposal_created_at"],
        proposalUpdatedAt: json["proposal_updated_at"],
        proposalState: json["proposal_state"],
        proposalValidPeriod: json["proposal_valid_period"],
        proposalDeliveryTime: json["proposal_delivery_time"],
        proposalValidDate: json["proposal_valid_date"],
        includeShipmentCost: json["include_shipment_cost"],
        paymentDueDate: json["payment_due_date"],
        deliveryDate: json["delivery_date"],
        customerCompany: json["customer_company"],
        customerCompanyId: json["customer_company_id"],
        sellerUserName: json["seller_user_name"],
        paymentType: json["payment_type"],
        updateCounter: json["update_counter"],
        notification: json["notification"],
        messageNotification: json["message_notification"],
        demandListName: json["demand_list_name"],
        productProposals: json["product_proposals"] == null ? [] : List<ProductProposal>.from(json["product_proposals"]!.map((x) => ProductProposal.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "proposal_id": proposalId,
        "proposal_created_at": proposalCreatedAt,
        "proposal_updated_at": proposalUpdatedAt,
        "proposal_state": proposalState,
        "proposal_valid_period": proposalValidPeriod,
        "proposal_delivery_time": proposalDeliveryTime,
        "proposal_valid_date": proposalValidDate,
        "include_shipment_cost": includeShipmentCost,
        "payment_due_date": paymentDueDate,
        "delivery_date": deliveryDate,
        "customer_company": customerCompany,
        "customer_company_id": customerCompanyId,
        "seller_user_name": sellerUserName,
        "payment_type": paymentType,
        "product_proposals": productProposals == null ? [] : List<dynamic>.from(productProposals!.map((x) => x.toMap())),
    };
}

class ProductProposal {
    int? productProposalId;
    Map? productFiles;
    Map? productsProposalFiles;
    String? productName;
    String? productCategory;
    String? productUnit;
    dynamic productErpId;
    String? updatedAt;
    double? price;
    String? url;
    String? description;
    int? productId;
    String? status;
    int? updateCount;
    String? equivalentId;
    String? proposalNote;
    int? taxRate;
    String? currencyCode;
    double? amount;

    ProductProposal({
        this.productProposalId,
        this.productFiles,
        this.productsProposalFiles,
        this.productName,
        this.productCategory,
        this.productUnit,
        this.productErpId,
        this.updatedAt,
        this.price,
        this.url,
        this.description,
        this.productId,
        this.status,
        this.updateCount,
        this.equivalentId,
        this.proposalNote,
        this.taxRate,
        this.currencyCode,
        this.amount,
    });

    factory ProductProposal.fromJson(String str) => ProductProposal.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductProposal.fromMap(Map<String, dynamic> json) => ProductProposal(
        productProposalId: json["product_proposal_id"],
        productFiles: json["product_files"],
        productsProposalFiles: json['products_proposal_files'],
        productName: json["product_name"],
        productCategory: json["product_category"],
        productUnit: json["product_unit"],
        productErpId: json["product_erp_id"],
        updatedAt: json["updated_at"],
        price: json["price"],
        url: json["url"],
        description: json["description"],
        productId: json["product_id"],
        status: json["status"],
        updateCount: json["update_count"],
        equivalentId: json["equivalent_id"],
        proposalNote: json["proposal_note"],
        taxRate: json["tax_rate"],
        currencyCode: json["currency_code"],
        amount: json["amount"],
    );

    Map<String, dynamic> toMap() => {
        "product_proposal_id": productProposalId,
        "product_name": productName,
        "product_category": productCategory,
        "product_unit": productUnit,
        "product_erp_id": productErpId,
        "updated_at": updatedAt,
        "price": price,
        "url": url,
        "description": description,
        "product_id": productId,
        "status": status,
        "update_count": updateCount,
        "equivalent_id": equivalentId,
        "proposal_note": proposalNote,
        "tax_rate": taxRate,
        "currency_code": currencyCode,
        "amount": amount,
    };
    @override
  String toString() {
    return 'ProductProposal(productProposalId: $productProposalId, productName: $productName, price: $price, url: $url, description: $description, productId: $productId, status: $status, updateCount: $updateCount, equivalentId: $equivalentId, proposalNote: $proposalNote, taxRate: $taxRate, currencyCode: $currencyCode, amount: $amount, productFiles: $productFiles, productsProposalFiles: $productsProposalFiles)';
  }
}


