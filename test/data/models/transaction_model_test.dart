import 'package:flutter_test/flutter_test.dart';
import 'package:fintrack/domain/entities/transaction.dart';
import 'package:fintrack/core/enums/transaction_type.dart';
import 'package:fintrack/data/models/transaction_model.dart';

void main() {
  group('TransactionModel', () {
    final tModel = TransactionModel(
      id: '123',
      title: 'Lanche',
      amount: 45.5,
      type: TransactionType.expense,
      date: DateTime(2026, 5, 20),
    );

    test('deve ser uma subclasse de Transaction', () {
      expect(tModel, isA<Transaction>());
    });

    test('toMap deve retornar um mapa JSON válido contendo os dados corretos', () {
      final result = tModel.toMap();

      final expectedMap = {
        'id': '123',
        'title': 'Lanche',
        'amount': 45.5,
        'type': 'expense',
        'date': '2026-05-20T00:00:00.000',
      };

      expect(result, equals(expectedMap));
    });

    test('fromMap deve retornar um modelo válido a partir do mapa', () {
      final map = {
        'id': '456',
        'title': 'Salário',
        'amount': 5000.0,
        'type': 'income',
        'date': '2026-06-01T00:00:00.000',
      };

      final result = TransactionModel.fromMap(map);

      expect(result.id, '456');
      expect(result.title, 'Salário');
      expect(result.amount, 5000.0);
      expect(result.type, TransactionType.income);
      expect(result.date, DateTime(2026, 6, 1));
    });
  });
}
