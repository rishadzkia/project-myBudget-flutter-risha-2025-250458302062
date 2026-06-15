part of 'transaksi_bloc.dart';

@freezed
class TransaksiState with _$TransaksiState {
  const factory TransaksiState.initial() = _Initial;
  const factory TransaksiState.loading() = _Loading;
  const factory TransaksiState.success( 
    List<TransactionModel> transactions,
  ) = _Success;
  const factory TransaksiState.error(String message) = _Error;
}
