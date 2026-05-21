import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_budget/data/remote/auth_remote_datasource.dart';
import 'package:my_budget/data/request/auth_request_model.dart';
import 'package:my_budget/data/response/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource _authRemoteDatasource;
  LoginBloc(this._authRemoteDatasource) : super(_Initial()) {
    on<_Login>((event, emit) async {
      emit(_Loading());
      final dataRequest = AuthRequestModel(
        email: event.email,
        password: event.password,
      );
      final response = await _authRemoteDatasource.login(dataRequest);
      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Success(data)),
      );
      // TODO: implement event handler
    });
  }
}
