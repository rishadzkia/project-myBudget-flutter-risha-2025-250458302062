import 'dart:convert';

class TransactionResponseModel {
  final List<TransactionModel> data;

  TransactionResponseModel({required this.data});

  factory TransactionResponseModel.fromJson(String str) =>
      TransactionResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionResponseModel.fromMap(Map<String, dynamic> json) =>
      TransactionResponseModel(
        data: json["data"] == null
            ? []
            : List<TransactionModel>.from(
                json["data"].map((x) => TransactionModel.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class TransactionCategoryModel {
  final int id;
  final String category;
  final String? icon;
  final String? color;

  TransactionCategoryModel({
    required this.id,
    required this.category,
    this.icon,
    this.color,
  });

  factory TransactionCategoryModel.fromMap(Map<String, dynamic> json) =>
      TransactionCategoryModel(
        id: json["id"],
        category: json["category"],
        icon: json["icon"],
        color: json["color"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category": category,
        "icon": icon,
        "color": color,
      };
}

class TransactionAccountModel {
  final int id;
  final String accountName;
  final String saldo;

  TransactionAccountModel({
    required this.id,
    required this.accountName,
    required this.saldo,
  });

  factory TransactionAccountModel.fromMap(Map<String, dynamic> json) =>
      TransactionAccountModel(
        id: json["id"],
        accountName: json["account_name"],
        saldo: json["saldo"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "account_name": accountName,
        "saldo": saldo,
      };
}

class TransactionModel {
  final int id;
  final int userId;
  final int accountId;
  final int? categoryId;
  final int? billId;
  final String type;
  final double amount;
  final String? transactionTime;
  final String? createdAt;
  final String? updatedAt;
  final TransactionCategoryModel? category;
  final TransactionAccountModel? account;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.accountId,
    this.categoryId,
    this.billId,
    required this.type,
    required this.amount,
    this.transactionTime,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.account,
  });

  factory TransactionModel.fromJson(String str) =>
      TransactionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromMap(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        userId: json["user_id"],
        accountId: json["account_id"],
        categoryId: json["category_id"],
        billId: json["bill_id"],
        type: json["type"],
        amount: double.tryParse(json["amount"].toString()) ?? 0,
        transactionTime: json["transaction_time"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        category: json["category"] != null
            ? TransactionCategoryModel.fromMap(json["category"])
            : null,
        account: json["account"] != null
            ? TransactionAccountModel.fromMap(json["account"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "account_id": accountId,
        "category_id": categoryId,
        "bill_id": billId,
        "type": type,
        "amount": amount,
        "transaction_time": transactionTime,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class CreateTransactionResponseModel {
  final String message;
  final TransactionModel data;

  CreateTransactionResponseModel({
    required this.message,
    required this.data,
  });

  factory CreateTransactionResponseModel.fromJson(String str) =>
      CreateTransactionResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateTransactionResponseModel.fromMap(Map<String, dynamic> json) =>
      CreateTransactionResponseModel(
        message: json["message"],
        data: TransactionModel.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data.toMap(),
      };
}
