part of 'transaksi_bloc.dart';

@freezed
class TransaksiEvent with _$TransaksiEvent {
  const factory TransaksiEvent.started() = _Started;
  const factory TransaksiEvent.getTransactions() = _GetTransactions;
  const factory TransaksiEvent.createTransactions(
    CreateTransactionRequestModel model,
  ) = _CreateTransaction;
  const factory TransaksiEvent.deleteTransaction(int id) = _DeleteTransaction;
}
