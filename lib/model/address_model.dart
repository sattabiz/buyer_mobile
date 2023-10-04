import 'dart:convert';

class AddressModel {
    int? id;
    String? name;
    String? address;
    String? phone;

    AddressModel({
        this.id,
        this.name,
        this.address,
        this.phone,
    });

    factory AddressModel.fromJson(String str) => AddressModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddressModel.fromMap(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
    };
}
