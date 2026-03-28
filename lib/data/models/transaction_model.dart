import '../../core/enums/transaction_type.dart';
import '../../domain/entities/transaction.dart';

/// Modelo de dados de Transação responsável por realizar
/// a conversão entre o banco de dados (SQLite) e a Entidade de Negócio.
class TransactionModel extends Transaction {
  const TransactionModel({
    required super.id,
    required super.title,
    required super.amount,
    required super.type,
    required super.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': type.name,
      'date': date.toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      title: map['title'] as String,
      amount: map['amount'] as double,
      type: TransactionType.values.firstWhere(
        (e) => e.name == map['type'] as String,
        orElse: () => TransactionType.expense,
      ),
      date: DateTime.parse(map['date'] as String),
    );
  }
}
