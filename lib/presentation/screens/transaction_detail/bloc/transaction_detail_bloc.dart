import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fintrack/domain/entities/transaction.dart';

import '../../../../domain/usecases/delete_transaction.dart';

part 'transaction_detail_event.dart';
part 'transaction_detail_state.dart';

class TransactionDetailBloc
    extends Bloc<TransactionDetailEvent, TransactionDetailState> {
  TransactionDetailBloc(this._deleteTransaction)
    : super(TransactionDetailInitial()) {
    on<TransactionDetailLoad>(_onTransactionDetailLoad);
    on<TransactionDetailDelete>(_onTransactionDetailDelete);
  }

  final DeleteTransaction _deleteTransaction;

  FutureOr<void> _onTransactionDetailLoad(
    TransactionDetailLoad event,
    Emitter<TransactionDetailState> emit,
  ) async {
    emit(TransactionDetailLoaded(transaction: event.transaction));
  }

  FutureOr<void> _onTransactionDetailDelete(
    TransactionDetailDelete event,
    Emitter<TransactionDetailState> emit,
  ) async {
    if (state is TransactionDetailDeleting) {
      return;
    }

    emit(TransactionDetailDeleting());

    await _deleteTransaction.call(event.transaction.id);

    emit(TransactionDetailDeleted());
  }
}
