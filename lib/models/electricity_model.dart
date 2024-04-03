
// To parse this JSON data, do
//
//     final electicityModel = electicityModelFromJson(jsonString);

import 'dart:convert';

ElecticityModel electicityModelFromJson(String str) => ElecticityModel.fromJson(json.decode(str));

String electicityModelToJson(ElecticityModel data) => json.encode(data.toJson());

class ElecticityModel {
    bool success;
    String message;
    List<Datum> data;

    ElecticityModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ElecticityModel.fromJson(Map<String, dynamic> json) => ElecticityModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String name;
    String provider;
    String icon;
    int minAmount;
    int maxAmount;

    Datum({
        required this.name,
        required this.provider,
        required this.icon,
        required this.minAmount,
        required this.maxAmount,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        provider: json["provider"],
        icon: json["icon"],
        minAmount: json["min_amount"],
        maxAmount: json["max_amount"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "provider": provider,
        "icon": icon,
        "min_amount": minAmount,
        "max_amount": maxAmount,
    };
}
