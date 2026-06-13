import 'dart:convert';

class AccountResponseModel {
  final List<Account> data;

  AccountResponseModel({
    required this.data,
  });

  factory AccountResponseModel.fromJson(String str) =>
      AccountResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountResponseModel.fromMap(Map<String, dynamic> json) =>
      AccountResponseModel(
        data: json["data"] == null
            ? []
            : List<Account>.from(
                json["data"].map((x) => Account.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Account {
  final int id;
  final int userId;
  final String accountName;
  final String saldo;
  final int symbol;
  final String? createdAt;
  final String? updatedAt;

  Account({
    required this.id,
    required this.userId,
    required this.accountName,
    required this.saldo,
    this.symbol = 0,
    this.createdAt,
    this.updatedAt,
  });

  factory Account.fromJson(String str) => Account.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Account.fromMap(Map<String, dynamic> json) => Account(
        id: json["id"],
        userId: json["user_id"],
        accountName: json["account_name"],
        saldo: json["saldo"].toString(),
        symbol: json["symbol"] ?? 0,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "account_name": accountName,
        "saldo": saldo,
        "symbol": symbol,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  factory Account.fromLocalMap(Map<String, dynamic> json) => Account(
        id: json["accountId"],
        userId: json["user_id"],
        accountName: json["account_name"],
        symbol: json["symbol"],
        saldo: json["saldo"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toLocalMap() => {
        "accountId": id,
        "user_id": userId,
        "account_name": accountName,
        "saldo": saldo,
        "symbol": symbol,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
