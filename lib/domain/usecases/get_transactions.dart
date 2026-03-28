import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

/// Caso de uso: Buscar todas as transações
class GetTransactions {
  final TransactionRepository _repository;

  const GetTransactions(this._repository);

  Future<List<Transaction>> call() {
    return _repository.getTransactions();
  }
}
