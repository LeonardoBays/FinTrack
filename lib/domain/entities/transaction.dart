import '../../core/enums/transaction_type.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final DateTime date;

  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  });

  bool get isIncome => type == TransactionType.income;

  bool get isExpense => type == TransactionType.expense;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Transaction(id: $id, title: $title, amount: $amount, type: $type, date: $date)';
}
