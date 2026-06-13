// lib/data/response/dana_terlindungi_response_model.dart
import 'dart:convert';

class DanaTerlindungiResponseModel {
  final List<DanaTerlindungi> data;
  final double total;

  DanaTerlindungiResponseModel({
    required this.data,
    required this.total,
  });

  factory DanaTerlindungiResponseModel.fromJson(String str) =>
      DanaTerlindungiResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DanaTerlindungiResponseModel.fromMap(Map<String, dynamic> json) =>
      DanaTerlindungiResponseModel(
        data: json["data"] == null
            ? []
            : List<DanaTerlindungi>.from(
                json["data"].map((x) => DanaTerlindungi.fromMap(x)),
              ),
        total: double.tryParse(json["total"].toString()) ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "total": total,
      };
}

class DanaTerlindungi {
  final int id;
  final int userId;
  final int accountId;
  final double nominal;
  final String? createdAt;
  final String? updatedAt;

  DanaTerlindungi({
    required this.id,
    required this.userId,
    required this.accountId,
    required this.nominal,
    this.createdAt,
    this.updatedAt,
  });

  factory DanaTerlindungi.fromJson(String str) =>
      DanaTerlindungi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DanaTerlindungi.fromMap(Map<String, dynamic> json) => DanaTerlindungi(
        id: json["id"],
        userId: json["user_id"],
        accountId: json["account_id"],
        nominal: double.tryParse(json["nominal"].toString()) ?? 0,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "account_id": accountId,
        "nominal": nominal,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class CreateDanaTerlindungiResponseModel {
  final String message;
  final DanaTerlindungi data;

  CreateDanaTerlindungiResponseModel({
    required this.message,
    required this.data,
  });

  factory CreateDanaTerlindungiResponseModel.fromJson(String str) =>
      CreateDanaTerlindungiResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateDanaTerlindungiResponseModel.fromMap(
          Map<String, dynamic> json) =>
      CreateDanaTerlindungiResponseModel(
        message: json["message"],
        data: DanaTerlindungi.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data.toMap(),
      };
}
