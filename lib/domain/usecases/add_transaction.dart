import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

/// Caso de uso: Adicionar uma nova transação
class AddTransaction {
  final TransactionRepository _repository;

  const AddTransaction(this._repository);

  Future<void> call(Transaction transaction) {
    return _repository.addTransaction(transaction);
  }
}
