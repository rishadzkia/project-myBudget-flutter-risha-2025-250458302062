// lib/data/request/create_transaction_request.dart
import 'dart:convert';

class CreateTransactionRequestModel {
  final int accountId;
  final int? categoryId;
  final String type;
  final double amount;
  final String? transactionTime;

  CreateTransactionRequestModel({
    required this.accountId,
    this.categoryId,
    required this.type,
    required this.amount,
    this.transactionTime,
  });

  factory CreateTransactionRequestModel.fromJson(String str) =>
      CreateTransactionRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateTransactionRequestModel.fromMap(Map<String, dynamic> json) =>
      CreateTransactionRequestModel(
        accountId: json["account_id"],
        categoryId: json["category_id"],
        type: json["type"],
        amount: double.tryParse(json["amount"].toString()) ?? 0,
        transactionTime: json["transaction_time"],
      );

  Map<String, dynamic> toMap() => {
        "account_id": accountId,
        if (categoryId != null) "category_id": categoryId,
        "type": type,
        "amount": amount,
        if (transactionTime != null) "transaction_time": transactionTime,
      };
}
