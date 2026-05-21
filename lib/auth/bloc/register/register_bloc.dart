import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_budget/data/remote/auth_remote_datasource.dart';
import 'package:my_budget/data/request/register_request_model.dart';
import 'package:my_budget/data/response/register_response_model.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource _authRemoteDatasource;
  RegisterBloc(this._authRemoteDatasource) : super(_Initial()) {
    on<_Register>((event, emit) async {
      emit(_Loading());
      final dataRequest = RegisterRequestModel(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      final response = await _authRemoteDatasource.register(dataRequest);
      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Success(data)),
      );
      // TODO: implement event handler
    });
  }
}
