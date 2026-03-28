import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/transaction_type.dart';
import '../../../../domain/entities/transaction.dart';
import '../../../../domain/usecases/add_transaction.dart';

part 'add_transaction_event.dart';
part 'add_transaction_state.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  AddTransactionBloc(this._addTransaction) : super(AddTransactionInitial()) {
    on<AddTransactionToggle>(_onAddTransactionToggle);
    on<AddTransactionLoad>(_onAddTransactionLoad);
    on<AddTransactionTitle>(_onAddTransactionTitle);
    on<AddTransactionAmount>(_onAddTransactionAmount);
    on<AddTransactionDate>(_onAddTransactionDate);
    on<AddTransactionSubmit>(_onAddTransactionSubmit);
  }

  final AddTransaction _addTransaction;

  FutureOr<void> _onAddTransactionLoad(
    AddTransactionLoad event,
    Emitter<AddTransactionState> emit,
  ) {
    final dtNow = DateTime.now();

    emit(
      AddTransactionLoaded(
        amount: state.amount,
        amountError: state.amountError,
        date: dtNow,
        title: state.title,
        titleError: state.titleError,
        transactionType: state.transactionType,
      ),
    );
  }

  FutureOr<void> _onAddTransactionToggle(
    AddTransactionToggle event,
    Emitter<AddTransactionState> emit,
  ) {
    emit(
      AddTransactionLoaded(
        amount: state.amount,
        amountError: state.amountError,
        date: state.date,
        title: state.title,
        titleError: state.titleError,
        transactionType: event.transactionType,
      ),
    );
  }

  FutureOr<void> _onAddTransactionTitle(
    AddTransactionTitle event,
    Emitter<AddTransactionState> emit,
  ) {
    emit(
      AddTransactionLoaded(
        amount: state.amount,
        amountError: state.amountError,
        date: state.date,
        title: event.title,
        titleError: null,
        transactionType: state.transactionType,
      ),
    );
  }

  FutureOr<void> _onAddTransactionAmount(
    AddTransactionAmount event,
    Emitter<AddTransactionState> emit,
  ) {
    emit(
      AddTransactionLoaded(
        amount: event.amount,
        amountError: null,
        date: state.date,
        title: state.title,
        titleError: state.titleError,
        transactionType: state.transactionType,
      ),
    );
  }

  FutureOr<void> _onAddTransactionDate(
    AddTransactionDate event,
    Emitter<AddTransactionState> emit,
  ) {
    emit(
      AddTransactionLoaded(
        amount: state.amount,
        amountError: state.amountError,
        date: event.date,
        title: state.title,
        titleError: state.titleError,
        transactionType: state.transactionType,
      ),
    );
  }

  FutureOr<void> _onAddTransactionSubmit(
    AddTransactionSubmit event,
    Emitter<AddTransactionState> emit,
  ) async {
    if (state is AddTransactionSaving) {
      return;
    }

    emit(
      AddTransactionSaving(
        amount: state.amount,
        amountError: state.amountError,
        date: state.date,
        title: state.title,
        titleError: state.titleError,
        transactionType: state.transactionType,
      ),
    );

    final title = state.title.trim();
    final amount = state.amount.trim().replaceAll(RegExp(r'[^0-9]'), '');
    final date = state.date ?? DateTime.now();

    String? titleError;
    String? amountError;

    if (title.trim().isEmpty) {
      titleError = 'Informe um título.';
    }

    if (amount.trim().isEmpty) {
      amountError = 'Informe um valor.';
    }

    if (titleError != null || amountError != null) {
      emit(
        AddTransactionLoaded(
          amount: state.amount,
          amountError: amountError,
          date: state.date,
          title: state.title,
          titleError: titleError,
          transactionType: state.transactionType,
        ),
      );
      return;
    }

    /// Remove mensagens de erro caso tinha antes de salvar
    emit(
      AddTransactionSaved(
        amount: state.amount,
        amountError: state.amountError,
        date: state.date,
        title: state.title,
        titleError: state.titleError,
        transactionType: state.transactionType,
      ),
    );

    final transaction = Transaction(
      id: const Uuid().v4(),
      title: title,
      amount: int.parse(amount)/100,
      type: state.transactionType,
      date: date,
    );

    await _addTransaction.call(transaction);

    emit(
      AddTransactionSaved(
        amount: state.amount,
        amountError: state.amountError,
        date: state.date,
        title: state.title,
        titleError: state.titleError,
        transactionType: state.transactionType,
      ),
    );
  }
}
