part of 'add_transaction_bloc.dart';

sealed class AddTransactionState extends Equatable {
  const AddTransactionState({
    this.title = '',
    this.amount = '',
    this.date,
    this.titleError,
    this.amountError,
    this.transactionType = TransactionType.income,
  });

  final String title;
  final String? titleError;
  final String amount;
  final String? amountError;
  final DateTime? date;
  final TransactionType transactionType;
}

final class AddTransactionInitial extends AddTransactionState {
  const AddTransactionInitial();

  @override
  List<Object> get props => [];
}

final class AddTransactionLoading extends AddTransactionState {
  const AddTransactionLoading();

  @override
  List<Object?> get props => [];
}

final class AddTransactionLoaded extends AddTransactionState {
  const AddTransactionLoaded({
    super.title,
    super.amount,
    super.date,
    super.titleError,
    super.amountError,
    super.transactionType,
  });

  @override
  List<Object?> get props => [
    title,
    amount,
    date,
    titleError,
    amountError,
    transactionType,
  ];
}

final class AddTransactionSaving extends AddTransactionState {
  const AddTransactionSaving({
    super.title,
    super.amount,
    super.date,
    super.titleError,
    super.amountError,
    super.transactionType,
  });

  @override
  List<Object?> get props => [
    title,
    amount,
    date,
    titleError,
    amountError,
    transactionType,
  ];
}

final class AddTransactionSaved extends AddTransactionState {
  const AddTransactionSaved({
    super.title,
    super.amount,
    super.date,
    super.titleError,
    super.amountError,
    super.transactionType,
  });

  @override
  List<Object?> get props => [
    title,
    amount,
    date,
    titleError,
    amountError,
    transactionType,
  ];
}
