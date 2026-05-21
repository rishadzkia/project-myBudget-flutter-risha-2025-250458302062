import 'package:my_budget/core/variable.dart';
import 'package:my_budget/data/local/auth_local_datasource.dart';
import 'package:my_budget/data/request/auth_request_model.dart';
import 'package:dartz/dartz.dart';
import 'package:my_budget/data/request/register_request_model.dart';
import 'package:my_budget/data/response/auth_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:my_budget/data/response/register_response_model.dart';

class AuthRemoteDatasource {
  // Untuk mengakses function login, harus masukkin request
  Future<Either<String, AuthResponseModel>> login(AuthRequestModel data) async {
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: data.toJson(),
    );
    // 201 itu response code untuk post

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  // Register
  Future<Either<String, RegisterResponsetModel>> register(
    RegisterRequestModel data,
  ) async {
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: data.toJson(),
    );
    if (response.statusCode == 201) {
      return Right(RegisterResponsetModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  // Logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/logout'),
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
