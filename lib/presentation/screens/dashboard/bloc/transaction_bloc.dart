import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/enums/transaction_type.dart';
import '../../../../domain/entities/transaction.dart';
import '../../../../domain/usecases/add_transaction.dart';
import '../../../../domain/usecases/get_balance.dart';
import '../../../../domain/usecases/get_transactions.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactions getTransactions;
  final AddTransaction addTransaction;
  final GetBalance getBalance;

  TransactionBloc({
    required this.getTransactions,
    required this.addTransaction,
    required this.getBalance,
  }) : super(const TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
  }

  /// Carrega todos as transações e calcula os totais
  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());
    try {
      final transactions = await getTransactions();
      final balance = await getBalance();
      final totalIncome = _sumByType(transactions, TransactionType.income);
      final totalExpense = _sumByType(transactions, TransactionType.expense);

      emit(
        TransactionLoaded(
          transactions: transactions,
          balance: balance,
          totalIncome: totalIncome,
          totalExpense: totalExpense,
        ),
      );
    } catch (e) {
      emit(TransactionError('Erro ao carregar transações: ${e.toString()}'));
    }
  }

  double _sumByType(List<Transaction> transactions, TransactionType type) {
    return transactions
        .where((t) => t.type == type)
        .fold(0.0, (sum, t) => sum + t.amount);
  }
}
