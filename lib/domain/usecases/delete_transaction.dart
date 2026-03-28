import '../repositories/transaction_repository.dart';

/// Caso de uso: Excluir uma transação pelo id
class DeleteTransaction {
  final TransactionRepository _repository;

  const DeleteTransaction(this._repository);

  Future<void> call(String id) {
    return _repository.deleteTransaction(id);
  }
}
