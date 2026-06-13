import 'dart:convert';

import 'package:my_budget/data/response/account_response_model.dart';

class CreateAccountResponseModel {
  final String message;
  final Account data;

  CreateAccountResponseModel({
    required this.message,
    required this.data,
  });

  factory CreateAccountResponseModel.fromJson(String str) =>
      CreateAccountResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateAccountResponseModel.fromMap(Map<String, dynamic> json) =>
      CreateAccountResponseModel(
        message: json["message"],
        data: Account.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data.toMap(),
      };
}
