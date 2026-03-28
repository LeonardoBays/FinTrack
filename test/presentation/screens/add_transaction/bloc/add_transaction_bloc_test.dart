import 'package:bloc_test/bloc_test.dart';
import 'package:fintrack/core/enums/transaction_type.dart';
import 'package:fintrack/domain/entities/transaction.dart';
import 'package:fintrack/presentation/screens/add_transaction/bloc/add_transaction_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dashboard/bloc/transaction_bloc_test.mocks.dart';

void main() {
  group('AddTransactionBloc', () {
    final fakeTransaction = Transaction(
      id: '1',
      title: 'Café',
      amount: 10.0,
      type: TransactionType.expense,
      date: DateTime(2026, 1, 1),
    );

    setUpAll(() {
      registerFallbackValue(fakeTransaction);
    });

    late MockAddTransaction mockAddTransaction;

    setUp(() {
      mockAddTransaction = MockAddTransaction();
    });

    AddTransactionBloc buildBloc() => AddTransactionBloc(mockAddTransaction);

    test('estado inicial é AddTransactionInitial', () {
      expect(buildBloc().state, isA<AddTransactionInitial>());
    });

    blocTest<AddTransactionBloc, AddTransactionState>(
      'emite AddTransactionLoaded ao receber AddTransactionLoad',
      build: buildBloc,
      act: (bloc) => bloc.add(const AddTransactionLoad()),
      expect: () => [
        isA<AddTransactionLoaded>()
            .having(
              (s) => s.transactionType,
              'transactionType',
              TransactionType.income,
            )
            .having((s) => s.title, 'title', '')
            .having((s) => s.amount, 'amount', '')
            .having((s) => s.date, 'date', isNotNull),
      ],
    );

    blocTest<AddTransactionBloc, AddTransactionState>(
      'emite AddTransactionLoaded ao receber AddTransactionToggle',
      build: buildBloc,
      act: (bloc) =>
          bloc.add(const AddTransactionToggle(TransactionType.expense)),
      expect: () => [
        isA<AddTransactionLoaded>().having(
          (s) => s.transactionType,
          'transactionType',
          TransactionType.expense,
        ),
      ],
    );

    blocTest<AddTransactionBloc, AddTransactionState>(
      'emite AddTransactionLoaded ao receber AddTransactionTitle',
      build: buildBloc,
      act: (bloc) => bloc.add(const AddTransactionTitle('Nova Transação')),
      expect: () => [
        isA<AddTransactionLoaded>().having(
          (s) => s.title,
          'title',
          'Nova Transação',
        ),
      ],
    );

    blocTest<AddTransactionBloc, AddTransactionState>(
      'emite AddTransactionLoaded ao receber AddTransactionAmount',
      build: buildBloc,
      act: (bloc) => bloc.add(const AddTransactionAmount('1000')),
      expect: () => [
        isA<AddTransactionLoaded>().having((s) => s.amount, 'amount', '1000'),
      ],
    );

    final date = DateTime(2026, 1, 1);
    blocTest<AddTransactionBloc, AddTransactionState>(
      'emite AddTransactionLoaded ao receber AddTransactionDate',
      build: buildBloc,
      act: (bloc) => bloc.add(AddTransactionDate(date)),
      expect: () => [
        isA<AddTransactionLoaded>().having((s) => s.date, 'date', date),
      ],
    );

    blocTest<AddTransactionBloc, AddTransactionState>(
      'emite erros quando submit é chamado com campos vazios',
      build: buildBloc,
      act: (bloc) {
        bloc.add(const AddTransactionToggle(TransactionType.expense));
        bloc.add(const AddTransactionSubmit());
      },
      expect: () => [
        isA<AddTransactionLoaded>(), // do toggle
        isA<AddTransactionSaving>(), // do submit
        isA<AddTransactionLoaded>() // com erros
            .having((s) => s.titleError, 'titleError', 'Informe um título.')
            .having((s) => s.amountError, 'amountError', 'Informe um valor.'),
      ],
    );

    blocTest<AddTransactionBloc, AddTransactionState>(
      'emite [AddTransactionSaving, AddTransactionSaved] com sucesso no submit',
      build: buildBloc,
      setUp: () {
        when(() => mockAddTransaction.call(any())).thenAnswer((_) async {});
      },
      act: (bloc) async {
        bloc.add(const AddTransactionTitle('Café'));
        bloc.add(const AddTransactionAmount('R\$ 10,00'));
        bloc.add(const AddTransactionSubmit());
      },
      expect: () => [
        isA<AddTransactionLoaded>().having((s) => s.title, 'title', 'Café'),
        isA<AddTransactionLoaded>().having(
          (s) => s.amount,
          'amount',
          'R\$ 10,00',
        ),
        isA<AddTransactionSaving>(),
        isA<AddTransactionSaved>().having(
          (s) => s.titleError,
          'titleError',
          null,
        ),
      ],
      verify: (_) {
        verify(() => mockAddTransaction.call(any())).called(1);
      },
    );
  });
}
