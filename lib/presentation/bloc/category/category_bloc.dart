import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_budget/data/remote/category_remote_datasource.dart';
import 'package:my_budget/data/request/category_request_model.dart';
import 'package:my_budget/data/response/category_response_model.dart';

part 'category_event.dart';
part 'category_state.dart';
part 'category_bloc.freezed.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRemoteDatasource categoryRemoteDatasource;
  CategoryBloc(this.categoryRemoteDatasource) : super(_Initial()) {
    List<Categori> categories = [];
    on<_GetCategories>((event, emit) async {
      emit(_Loading());
      final response = await categoryRemoteDatasource.getCategories();
      await response.fold<Future<void>>((error) async {
        emit(_Error(error));
      }, (data) async {
        categories = data.data;
        emit(_Success(categories));
      });
      // TODO: implement event handler
    });

    on<_CreateCategory>((event, emit) async {
      emit(_Loading());
      final response =
          await categoryRemoteDatasource.createCategories(event.model);
      await response.fold<Future<void>>((error) async {
        emit(_Error(error));
      }, (data) async {
        categories.add(data.data);
        emit(_Success(categories));
      });
    });

    on<_DeleteCategory>((event, emit) async {
      emit(_Loading());
      final response =
          await categoryRemoteDatasource.deleteCategories(event.id);
      await response.fold<Future<void>>((error) async {
        emit(_Error(error));
      }, (data) async {
        categories.removeWhere((category) => category.id == event.id);
        emit(_Success(categories));
      });
    });
  }
}
