import 'package:dartz/dartz.dart';
import 'package:my_budget/core/variable.dart';
import 'package:my_budget/data/local/auth_local_datasource.dart';
import 'package:my_budget/data/request/dana_terlindungi_request_model.dart';
import 'package:my_budget/data/response/account_response_model.dart';
import 'package:my_budget/data/response/dana_terlindungi_response_model.dart';
import 'package:http/http.dart' as http;

class DanaTerlindungiRemoteDatasource {
  Future<Either<String, DanaTerlindungiResponseModel>> getDanaTer() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/api-dana-terlindungi'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        });
    if (response.statusCode == 200) {
      return Right(DanaTerlindungiResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, CreateDanaTerlindungiResponseModel>> createDanaTerlindungi(
      CreateDanaTerlindungiRequestModel model) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/api-dana-terlindungi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
      body: model.toJson(),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Right(CreateDanaTerlindungiResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}
