part of 'transaction_detail_bloc.dart';

sealed class TransactionDetailState extends Equatable {
  const TransactionDetailState();
}

final class TransactionDetailInitial extends TransactionDetailState {
  const TransactionDetailInitial();

  @override
  List<Object> get props => [];
}

final class TransactionDetailLoaded extends TransactionDetailState {
  const TransactionDetailLoaded({required this.transaction});

  final Transaction transaction;

  @override
  List<Object> get props => [transaction];
}

final class TransactionDetailDeleting extends TransactionDetailState {
  const TransactionDetailDeleting();

  @override
  List<Object> get props => [];
}

final class TransactionDetailDeleted extends TransactionDetailState {
  const TransactionDetailDeleted();

  @override
  List<Object> get props => [];
}
