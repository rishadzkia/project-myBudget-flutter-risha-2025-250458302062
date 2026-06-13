import 'dart:convert';

class CreateAccountRequestModel {
  final String accountName;
  final int saldo;
  final int symbol;

  CreateAccountRequestModel({
    required this.accountName, 
    required this.saldo,
    required this.symbol,
  });

  factory CreateAccountRequestModel.fromJson(String str) =>
      CreateAccountRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateAccountRequestModel.fromMap(Map<String, dynamic> json) =>
      CreateAccountRequestModel(
        accountName: json["account_name"],
        saldo: json["saldo"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toMap() => {
        "account_name": accountName,
        "saldo": saldo,
        "symbol": symbol,
      };
}
