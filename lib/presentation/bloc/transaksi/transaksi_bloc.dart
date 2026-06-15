import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_budget/data/remote/transaksi_remote_datasource.dart';
import 'package:my_budget/data/request/transkasi_request_model.dart';
import 'package:my_budget/data/response/transaksi_response_model.dart';

part 'transaksi_event.dart';
part 'transaksi_state.dart';
part 'transaksi_bloc.freezed.dart';

class TransaksiBloc extends Bloc<TransaksiEvent, TransaksiState> {
  final TransaksiRemoteDatasource transaksiRemoteDatasource;

  List<TransactionModel> transactions = [];

  TransaksiBloc(this.transaksiRemoteDatasource) : super(const _Initial()) {
    on<_GetTransactions>(_onGetTransactions);
    on<_CreateTransaction>(_onCreateTransaction);
    on<_DeleteTransaction>(_onDeleteTransaction);
  }

  Future<void> _onGetTransactions(
    _GetTransactions event,
    Emitter<TransaksiState> emit,
  ) async {
    emit(const _Loading());

    final response = await transaksiRemoteDatasource.getTransactions();

    await response.fold(
      (error) async {
        emit(_Error(error));
      },
      (data) async {
        transactions = data.data;
        emit(_Success(List.from(transactions)));
      },
    );
  }

  Future<void> _onCreateTransaction(
    _CreateTransaction event,
    Emitter<TransaksiState> emit,
  ) async {
    emit(const _Loading());

    final response = await transaksiRemoteDatasource.createTransactions(
      event.model,
    );

    await response.fold(
      (error) async {
        emit(_Error(error));
      },
      (data) async {
        transactions.add(data.data);
        emit(_Success(List.from(transactions)));
      },
    );
  }

  Future<void> _onDeleteTransaction(
    _DeleteTransaction event,
    Emitter<TransaksiState> emit,
  ) async {
    emit(const _Loading());

    final response = await transaksiRemoteDatasource.deleteTransactions(
      event.id,
    );

    await response.fold(
      (error) async {
        emit(_Error(error));
      },
      (data) async {
        transactions.removeWhere(
          (transaction) => transaction.id == event.id,
        );

        emit(_Success(List.from(transactions)));
      },
    );
  }
}
