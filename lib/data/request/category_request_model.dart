// lib/data/request/create_category_request.dart
import 'dart:convert';

class CreateCategoryRequestModel {
  final String category;
  final String? icon;
  final String? color;

  CreateCategoryRequestModel({
    required this.category,
    this.icon,
    this.color,
  });

  factory CreateCategoryRequestModel.fromJson(String str) =>
      CreateCategoryRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateCategoryRequestModel.fromMap(Map<String, dynamic> json) =>
      CreateCategoryRequestModel(
        category: json["category"],
        icon: json["icon"],
        color: json["color"],
      );

  Map<String, dynamic> toMap() => {
        "category": category,
        "icon": icon,
        "color": color,
      };
}
