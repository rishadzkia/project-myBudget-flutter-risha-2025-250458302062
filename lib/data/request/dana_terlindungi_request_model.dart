// lib/data/request/create_dana_terlindungi_request.dart
import 'dart:convert';

class CreateDanaTerlindungiRequestModel {
  final int accountId;
  final int nominal;

  CreateDanaTerlindungiRequestModel({
    required this.accountId,
    required this.nominal,
  });

  factory CreateDanaTerlindungiRequestModel.fromJson(String str) =>
      CreateDanaTerlindungiRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateDanaTerlindungiRequestModel.fromMap(
          Map<String, dynamic> json) =>
      CreateDanaTerlindungiRequestModel(
        accountId: json["account_id"],
        nominal: json["nominal"],
      );

  Map<String, dynamic> toMap() => {
        "account_id": accountId,
        "nominal": nominal,
      };
}
