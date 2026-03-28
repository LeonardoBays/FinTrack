import 'package:bloc_test/bloc_test.dart';
import 'package:fintrack/core/enums/transaction_type.dart';
import 'package:fintrack/domain/entities/transaction.dart';
import 'package:fintrack/domain/usecases/add_transaction.dart';
import 'package:fintrack/domain/usecases/delete_transaction.dart';
import 'package:fintrack/domain/usecases/get_balance.dart';
import 'package:fintrack/domain/usecases/get_transactions.dart';
import 'package:fintrack/presentation/screens/dashboard/bloc/transaction_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'transaction_bloc_test.mocks.dart';

@GenerateMocks([GetTransactions, AddTransaction, DeleteTransaction, GetBalance])
void main() {
  group('TransactionBloc', () {
    late MockGetTransactions mockGetTransactions;
    late MockAddTransaction mockAddTransaction;
    late MockGetBalance mockGetBalance;

    final fakeTransactions = [
      Transaction(
        id: '1',
        title: 'Salário',
        amount: 3000,
        type: TransactionType.income,
        date: DateTime(2026, 1, 1),
      ),
      Transaction(
        id: '2',
        title: 'Aluguel',
        amount: 1000,
        type: TransactionType.expense,
        date: DateTime(2026, 1, 5),
      ),
    ];

    setUp(() {
      mockGetTransactions = MockGetTransactions();
      mockAddTransaction = MockAddTransaction();
      mockGetBalance = MockGetBalance();
    });

    TransactionBloc buildBloc() => TransactionBloc(
      getTransactions: mockGetTransactions,
      addTransaction: mockAddTransaction,
      getBalance: mockGetBalance,
    );

    blocTest<TransactionBloc, TransactionState>(
      'emite [TransactionLoading, TransactionLoaded] ao receber LoadTransactions',
      build: buildBloc,
      setUp: () {
        when(mockGetTransactions()).thenAnswer((_) async => fakeTransactions);
        when(mockGetBalance()).thenAnswer((_) async => 2000.0);
      },
      act: (bloc) => bloc.add(const LoadTransactions()),
      expect: () => [
        const TransactionLoading(),
        isA<TransactionLoaded>()
            .having((s) => s.balance, 'balance', 2000.0)
            .having((s) => s.transactions.length, 'length', 2),
      ],
    );

    blocTest<TransactionBloc, TransactionState>(
      'emite [TransactionLoaded] com lista vazia quando não há transações',
      build: buildBloc,
      setUp: () {
        when(mockGetTransactions()).thenAnswer((_) async => []);
        when(mockGetBalance()).thenAnswer((_) async => 0.0);
      },
      act: (bloc) => bloc.add(const LoadTransactions()),
      expect: () => [
        const TransactionLoading(),
        isA<TransactionLoaded>()
            .having((s) => s.balance, 'balance', 0.0)
            .having((s) => s.transactions, 'transactions', isEmpty),
      ],
    );

    blocTest<TransactionBloc, TransactionState>(
      'emite [TransactionError] quando getTransactions lança exceção',
      build: buildBloc,
      setUp: () {
        when(mockGetTransactions()).thenThrow(Exception('Falha de rede'));
      },
      act: (bloc) => bloc.add(const LoadTransactions()),
      expect: () => [const TransactionLoading(), isA<TransactionError>()],
    );
  });
}
