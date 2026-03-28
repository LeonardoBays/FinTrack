part of 'transaction_detail_bloc.dart';

sealed class TransactionDetailEvent extends Equatable {
  const TransactionDetailEvent();
}

final class TransactionDetailLoad extends TransactionDetailEvent {
  const TransactionDetailLoad({required this.transaction});

  final Transaction transaction;

  @override
  List<Object> get props => [transaction];
}

final class TransactionDetailDelete extends TransactionDetailEvent {
  const TransactionDetailDelete({required this.transaction});

  final Transaction transaction;

  @override
  List<Object> get props => [transaction];
}