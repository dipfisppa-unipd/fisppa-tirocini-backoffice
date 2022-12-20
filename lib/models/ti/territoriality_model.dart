// To parse this JSON data, do
//
//     final terroitorialityModel = terroitorialityModelFromMap(jsonString);

import 'dart:convert';

class TerritorialityModel {
    TerritorialityModel({
        this.id,
        this.label,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    String? label;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory TerritorialityModel.fromJson(String str) => TerritorialityModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TerritorialityModel.fromMap(Map<String, dynamic> json) => TerritorialityModel(
        id: json["_id"] == null ? null : json["_id"],
        label: json["label"] == null ? null : json["label"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "label": label == null ? null : label,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}
