import 'package:fintrack/core/enums/transaction_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fintrack/domain/entities/transaction.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart';
import 'package:fintrack/domain/usecases/get_transactions.dart';

import 'get_transactions_test.mocks.dart';

@GenerateMocks([TransactionRepository])
void main() {
  group('GetTransactions UseCase', () {
    late MockTransactionRepository mockRepository;
    late GetTransactions useCase;

    final fakeTransactions = [
      Transaction(
        id: '1',
        title: 'Salário',
        amount: 4000,
        type: TransactionType.income,
        date: DateTime(2026, 1, 5),
      ),
      Transaction(
        id: '2',
        title: 'Internet',
        amount: 120,
        type: TransactionType.expense,
        date: DateTime(2026, 1, 10),
      ),
    ];

    setUp(() {
      mockRepository = MockTransactionRepository();
      useCase = GetTransactions(mockRepository);
    });

    test('deve retornar a lista de transações do repositório', () async {
      when(mockRepository.getTransactions())
          .thenAnswer((_) async => fakeTransactions);

      final result = await useCase();

      expect(result, equals(fakeTransactions));
      expect(result.length, equals(2));
      verify(mockRepository.getTransactions()).called(1);
    });

    test('deve retornar lista vazia quando não há transações', () async {
      when(mockRepository.getTransactions()).thenAnswer((_) async => []);

      final result = await useCase();

      expect(result, isEmpty);
    });
  });
}
