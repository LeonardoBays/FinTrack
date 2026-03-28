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