part of 'account_bloc.dart';

@freezed
class AccountEvent with _$AccountEvent {
  const factory AccountEvent.started() = _Started;
  const factory AccountEvent.getAccounts() = _GetAccounts;
  const factory AccountEvent.createAccount(CreateAccountRequestModel model) =
      _CreateAccount;
  const factory AccountEvent.deleteAccount(int id) = _DeleteAccount;
  const factory AccountEvent.updateAccount(
      {required CreateAccountRequestModel model,
      required int id}) = _UpdateAccount;
}
