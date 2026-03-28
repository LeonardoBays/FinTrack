part of 'transaction_bloc.dart';

/// Eventos que o usuário ou sistema pode disparar para o TransactionBloc
abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

/// Solicita o carregamento de todas as transações
class LoadTransactions extends TransactionEvent {
  const LoadTransactions();
}

/// Solicita a adição de uma nova transação
class AddTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  const AddTransactionEvent(this.transaction);

  @override
  List<Object?> get props => [transaction];
}
