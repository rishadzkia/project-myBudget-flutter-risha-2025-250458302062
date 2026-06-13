import 'package:dartz/dartz.dart';
import 'package:my_budget/core/variable.dart';
import 'package:my_budget/data/local/auth_local_datasource.dart';
import 'package:my_budget/data/request/create_account_request.dart';
import 'package:my_budget/data/response/account_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:my_budget/data/response/create_account_response_model.dart';

class AccountRemoteDatasource {
  Future<Either<String, AccountResponseModel>> getAccounts() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/api-accounts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        });
    if (response.statusCode == 200) {
      return Right(AccountResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, CreateAccountResponseModel>> createAccount(
      CreateAccountRequestModel model) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/api-accounts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
      body: model.toJson(),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Right(CreateAccountResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> deleteAccount(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.delete(
      Uri.parse('${Variable.baseUrl}/api/api-accounts/$id'),
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

  Future<Either<String, CreateAccountResponseModel>> updateAccount(
      CreateAccountRequestModel model, int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.patch(
      Uri.parse('${Variable.baseUrl}/api/api-accounts/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
      body: model.toJson(),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Right(CreateAccountResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}
