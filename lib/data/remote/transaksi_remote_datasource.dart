import 'package:dartz/dartz.dart';
import 'package:my_budget/core/variable.dart';
import 'package:my_budget/data/local/auth_local_datasource.dart';
import 'package:my_budget/data/request/transkasi_request_model.dart';
import 'package:my_budget/data/response/account_response_model.dart';
import 'package:my_budget/data/response/transaksi_response_model.dart';
import 'package:http/http.dart' as http;

class TransaksiRemoteDatasource {
  Future<Either<String, TransactionResponseModel>> getTransactions() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/api-transactions'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        });
    if (response.statusCode == 200) {
      return Right(TransactionResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, CreateTransactionResponseModel>> createTransactions(
      CreateTransactionRequestModel model) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/api-transactions'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
      body: model.toJson(),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Right(CreateTransactionResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> deleteTransactions(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.delete(
      Uri.parse('${Variable.baseUrl}/api/api-transactions/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
    );
    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }
}
