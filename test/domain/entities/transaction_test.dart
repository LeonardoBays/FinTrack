import 'package:flutter_test/flutter_test.dart';
import 'package:fintrack/domain/entities/transaction.dart';
import 'package:fintrack/core/enums/transaction_type.dart';

void main() {
  group('Transaction Entity getters', () {
    test('isIncome DEVE ser true se o tipo for income', () {
      final t = Transaction(
        id: '1',
        title: 'Depósito',
        amount: 100,
        type: TransactionType.income,
        date: DateTime.now(),
      );
      expect(t.isIncome, isTrue);
      expect(t.isExpense, isFalse);
    });

    test('isExpense DEVE ser true se o tipo for expense', () {
      final t = Transaction(
        id: '2',
        title: 'Boleto',
        amount: 100,
        type: TransactionType.expense,
        date: DateTime.now(),
      );
      expect(t.isExpense, isTrue);
      expect(t.isIncome, isFalse);
    });
  });
}
