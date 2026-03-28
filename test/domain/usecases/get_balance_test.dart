import 'package:fintrack/core/enums/transaction_type.dart';
import 'package:fintrack/domain/entities/transaction.dart';
import 'package:fintrack/domain/usecases/get_balance.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'get_balance_test.mocks.dart';

void main() {
  group('GetBalance UseCase', () {
    late MockTransactionRepository mockRepository;
    late GetBalance useCase;

    setUp(() {
      mockRepository = MockTransactionRepository();
      useCase = GetBalance(mockRepository);
    });

    test('deve calcular saldo correto com receitas e despesas', () async {
      final transactions = [
        Transaction(
          id: '1',
          title: 'Salário',
          amount: 5000,
          type: TransactionType.income,
          date: DateTime(2026, 1, 1),
        ),
        Transaction(
          id: '2',
          title: 'Aluguel',
          amount: 1500,
          type: TransactionType.expense,
          date: DateTime(2026, 1, 5),
        ),
        Transaction(
          id: '3',
          title: 'Mercado',
          amount: 300,
          type: TransactionType.expense,
          date: DateTime(2026, 1, 10),
        ),
      ];

      when(
        () => mockRepository.getTransactions(),
      ).thenAnswer((_) async => transactions);

      final balance = await useCase();

      // 5000 - 1500 - 300 = 3200
      expect(balance, equals(3200.0));
    });

    test('deve retornar zero para lista vazia', () async {
      when(() => mockRepository.getTransactions()).thenAnswer((_) async => []);

      final balance = await useCase();

      expect(balance, equals(0.0));
    });

    test('deve retornar valor positivo apenas com receitas', () async {
      final transactions = [
        Transaction(
          id: '1',
          title: 'Freelance',
          amount: 2000,
          type: TransactionType.income,
          date: DateTime(2026, 2, 1),
        ),
      ];

      when(
        () => mockRepository.getTransactions(),
      ).thenAnswer((_) async => transactions);

      final balance = await useCase();

      expect(balance, equals(2000.0));
    });

    test('deve retornar valor negativo apenas com despesas', () async {
      final transactions = [
        Transaction(
          id: '1',
          title: 'Conta de Luz',
          amount: 400,
          type: TransactionType.expense,
          date: DateTime(2026, 2, 5),
        ),
      ];

      when(
        () => mockRepository.getTransactions(),
      ).thenAnswer((_) async => transactions);

      final balance = await useCase();

      expect(balance, equals(-400.0));
    });
  });
}
