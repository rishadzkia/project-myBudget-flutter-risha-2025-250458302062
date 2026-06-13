import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_budget/data/remote/dana_terlindungi_remote_datasource.dart';
import 'package:my_budget/data/request/dana_terlindungi_request_model.dart';
import 'package:my_budget/data/response/dana_terlindungi_response_model.dart';

part 'danaterlindungi_event.dart';
part 'danaterlindungi_state.dart';
part 'danaterlindungi_bloc.freezed.dart';

class DanaterlindungiBloc
    extends Bloc<DanaterlindungiEvent, DanaterlindungiState> {
  final DanaTerlindungiRemoteDatasource danaTerlindungiRemoteDatasource;
  DanaterlindungiBloc(this.danaTerlindungiRemoteDatasource)
      : super(_Initial()) {
    List<DanaTerlindungi> dataList = [];
    double total = 0;

    on<DanaterlindungiEvent>((event, emit) async {
      emit(_Loading());
      final response = await danaTerlindungiRemoteDatasource.getDanaTer();
      await response.fold<Future<void>>((error) async {
        emit(_Error(error));
      }, (data) async {
        dataList = data.data;
        total = data.total;
        emit(_Success(dataList, total));
      });
      // TODO: implement event handler
    });

    on<_CreateDanaTerlindungi>((event, emit) async {
      emit(_Loading());
      final response = await danaTerlindungiRemoteDatasource
          .createDanaTerlindungi(event.model);
      await response.fold<Future<void>>((error) async {
        emit(_Error(error));
      }, (data) async {
        dataList.add(data.data);
        total += data.data.nominal;
        emit(_Success(dataList, total));
      });
    });
  }
}
