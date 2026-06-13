import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_budget/data/remote/account_remote_datasource.dart';
import 'package:my_budget/data/request/create_account_request.dart';
import 'package:my_budget/data/response/account_response_model.dart';

part 'account_event.dart';
part 'account_state.dart';
part 'account_bloc.freezed.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRemoteDatasource accountRemoteDatasource;
  AccountBloc(this.accountRemoteDatasource) : super(_Initial()) {
    List<Account> accounts = [];

    on<_GetAccounts>((event, emit) async {
      emit(_Loading());
      final response = await accountRemoteDatasource.getAccounts();
      response.fold((error) => emit(_Error(error)), (data) {
        accounts = data.data;
        emit(_Success(accounts));
      });
    });
    on<AccountEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<_CreateAccount>((event, emit) async {
      emit(_Loading());
      final response = await accountRemoteDatasource.createAccount(event.model);

      await response.fold<Future<void>>((error) async {
        emit(_Error(error));
      }, (data) async {
        accounts.add(data.data);
        emit(_Success(accounts));
      });
    });

    on<_UpdateAccount>((event, emit) async {
      emit(_Loading());
      final response =
          await accountRemoteDatasource.updateAccount(event.model, event.id);

      await response.fold<Future<void>>((error) async {
        emit(_Error(error));
      }, (data) async {
        final updateAccount = accounts.map((account) {
          if (account.id == event.id) {
            return data.data;
          }
          return account;
        }).toList();
        accounts = updateAccount;
        emit(_Success(accounts));
      });
    });

    on<_DeleteAccount>((event, emit) async {
      emit(_Loading());
      final response = await accountRemoteDatasource.deleteAccount(event.id);

      await response.fold<Future<void>>((error) async {
        emit(_Error(error));
      }, (data) async {
        accounts.removeWhere((account) => account.id == event.id);
        emit(_Success(accounts));
      });
    });
  }
}
