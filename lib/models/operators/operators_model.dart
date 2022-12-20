// To parse this JSON data, do
//
//     final operatorsModel = operatorsModelFromMap(jsonString);

import 'dart:convert';

import 'package:unipd_tirocini/models/user.dart';

class OperatorsModel {
    OperatorsModel({
        required this.users,
        required this.total,
    });

    final List<UserModel>? users;
    final int total;

    factory OperatorsModel.fromJson(String str) => OperatorsModel.fromMap(json.decode(str));

    factory OperatorsModel.fromMap(Map<String, dynamic> json) => OperatorsModel(
        users: json["users"] == null ? null : List<UserModel>.from(json["users"].map((x) => UserModel.fromMap(x))),
        total: json["total"] == null ? null : json["total"],
    );


}

