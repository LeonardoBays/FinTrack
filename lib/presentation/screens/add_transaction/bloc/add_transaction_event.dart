part of 'add_transaction_bloc.dart';

sealed class AddTransactionEvent extends Equatable {
  const AddTransactionEvent();
}

final class AddTransactionToggle extends AddTransactionEvent {
  const AddTransactionToggle(this.transactionType);

  final TransactionType transactionType;

  @override
  List<Object> get props => [transactionType];
}

final class AddTransactionLoad extends AddTransactionEvent {
  const AddTransactionLoad();

  @override
  List<Object> get props => [];
}

final class AddTransactionTitle extends AddTransactionEvent {
  const AddTransactionTitle(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

final class AddTransactionAmount extends AddTransactionEvent {
  const AddTransactionAmount(this.amount);

  final String amount;

  @override
  List<Object> get props => [amount];
}

final class AddTransactionDate extends AddTransactionEvent {
  const AddTransactionDate(this.date);

  final DateTime date;

  @override
  List<Object> get props => [date];
}

final class AddTransactionSubmit extends AddTransactionEvent {
  const AddTransactionSubmit();

  @override
  List<Object> get props => [];
}
