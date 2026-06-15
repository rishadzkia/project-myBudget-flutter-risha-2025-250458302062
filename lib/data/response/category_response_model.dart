// lib/data/response/category_response_model.dart
import 'dart:convert';

class CategoryResponseModel {
  final List<Categori> data;

  CategoryResponseModel({required this.data});

  factory CategoryResponseModel.fromJson(String str) =>
      CategoryResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryResponseModel.fromMap(Map<String, dynamic> json) =>
      CategoryResponseModel(
        data: json["data"] == null
            ? []
            : List<Categori>.from(
                json["data"].map((x) => Categori.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Categori {
  final int id;
  final int userId;
  final String category;
  final String? icon;
  final String? color;
  final String? createdAt;
  final String? updatedAt;

  Categori({
    required this.id,
    required this.userId,
    required this.category,
    this.icon,
    this.color,
    this.createdAt,
    this.updatedAt,
  });

  factory Categori.fromJson(String str) => Categori.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Categori.fromMap(Map<String, dynamic> json) => Categori(
        id: json["id"],
        userId: json["user_id"],
        category: json["category"],
        icon: json["icon"],
        color: json["color"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "category": category,
        "icon": icon,
        "color": color,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class CreateCategoryResponseModel {
  final String message;
  final Categori data;

  CreateCategoryResponseModel({
    required this.message,
    required this.data,
  });

  factory CreateCategoryResponseModel.fromJson(String str) =>
      CreateCategoryResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateCategoryResponseModel.fromMap(Map<String, dynamic> json) =>
      CreateCategoryResponseModel(
        message: json["message"],
        data: Categori.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data.toMap(),
      };
}
