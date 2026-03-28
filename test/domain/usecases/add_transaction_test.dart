import 'package:fintrack/core/enums/transaction_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fintrack/domain/entities/transaction.dart';
import 'package:fintrack/domain/usecases/add_transaction.dart';
import 'package:mocktail/mocktail.dart';

import 'add_transaction_test.mocks.dart';

void main() {
  group('AddTransaction UseCase', () {
    late MockTransactionRepository mockRepository;
    late AddTransaction useCase;

    setUp(() {
      mockRepository = MockTransactionRepository();
      useCase = AddTransaction(mockRepository);
    });

    test('deve chamar repository.addTransaction com a transação correta',
        () async {
      final transaction = Transaction(
        id: 'abc',
        title: 'Freelance',
        amount: 1500.0,
        type: TransactionType.income,
        date: DateTime(2026, 2, 15),
      );

      when(() => mockRepository.addTransaction(transaction))
          .thenAnswer((_) async {});

      await useCase(transaction);

      verify(() => mockRepository.addTransaction(transaction)).called(1);
    });

    test('deve propagar exceção se o repositório falhar', () async {
      final transaction = Transaction(
        id: 'xyz',
        title: 'Falha',
        amount: 100.0,
        type: TransactionType.expense,
        date: DateTime(2026, 3, 1),
      );

      when(() => mockRepository.addTransaction(transaction))
          .thenThrow(Exception('Erro no banco'));

      expect(() => useCase(transaction), throwsException);
    });
  });
}
