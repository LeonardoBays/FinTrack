import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

/// Caso de uso: Calcular saldo (receitas - despesas)
class GetBalance {
  final TransactionRepository _repository;

  const GetBalance(this._repository);

  Future<double> call() async {
    final transactions = await _repository.getTransactions();
    return _calculateBalance(transactions);
  }

  double _calculateBalance(List<Transaction> transactions) {
    return transactions.fold(0.0, (total, t) {
      return t.isIncome ? total + t.amount : total - t.amount;
    });
  }
}
