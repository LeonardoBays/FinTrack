import '../entities/transaction.dart';

/// Contrato abstrato do repositório de transações
/// Define as operações disponíveis sem depender de implementação concreta
abstract class TransactionRepository {
  /// Retorna todas as transações armazenadas
  Future<List<Transaction>> getTransactions();

  /// Persiste uma nova transação
  Future<void> addTransaction(Transaction transaction);

  /// Remove a transação com o [id] informado
  Future<void> deleteTransaction(String id);
}
