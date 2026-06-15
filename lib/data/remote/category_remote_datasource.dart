import 'package:dartz/dartz.dart';
import 'package:my_budget/core/variable.dart';
import 'package:my_budget/data/local/auth_local_datasource.dart';
import 'package:my_budget/data/request/category_request_model.dart';
import 'package:my_budget/data/response/account_response_model.dart';
import 'package:my_budget/data/response/category_response_model.dart';
import 'package:http/http.dart' as http;

class CategoryRemoteDatasource {
  Future<Either<String, CategoryResponseModel>> getCategories() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/api-categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        });
    if (response.statusCode == 200) {
      return Right(CategoryResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, CreateCategoryResponseModel>> createCategories(
      CreateCategoryRequestModel model) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/api-categories'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
      body: model.toJson(),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Right(CreateCategoryResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> deleteCategories(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.delete(
      Uri.parse('${Variable.baseUrl}/api/api-categories/$id'),
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

  Future<Either<String, CreateCategoryResponseModel>> updateCategories(
      CreateCategoryResponseModel model, int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.patch(
      Uri.parse('${Variable.baseUrl}/api/api-categories/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      },
      body: model.toJson(),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Right(CreateCategoryResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}
