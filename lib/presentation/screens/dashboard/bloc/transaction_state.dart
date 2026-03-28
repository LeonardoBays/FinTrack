part of 'transaction_bloc.dart';

/// Estados emitidos pelo TransactionBloc
abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial antes de qualquer carregamento
class TransactionInitial extends TransactionState {
  const TransactionInitial();
}

/// Carregamento em andamento
class TransactionLoading extends TransactionState {
  const TransactionLoading();
}

/// Dados carregados com sucesso
class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  final double balance;
  final double totalIncome;
  final double totalExpense;

  const TransactionLoaded({
    required this.transactions,
    required this.balance,
    required this.totalIncome,
    required this.totalExpense,
  });

  @override
  List<Object?> get props => [transactions, balance, totalIncome, totalExpense];
}

/// Erro ao processar alguma operação
class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object?> get props => [message];
}
