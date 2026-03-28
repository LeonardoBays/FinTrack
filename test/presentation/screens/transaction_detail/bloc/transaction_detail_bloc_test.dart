import 'package:bloc_test/bloc_test.dart';
import 'package:fintrack/core/enums/transaction_type.dart';
import 'package:fintrack/domain/entities/transaction.dart';
import 'package:fintrack/domain/usecases/delete_transaction.dart';
import 'package:fintrack/presentation/screens/transaction_detail/bloc/transaction_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dashboard/bloc/transaction_bloc_test.mocks.dart';

@GenerateMocks([DeleteTransaction])
void main() {
  group('TransactionDetailBloc', () {
    late MockDeleteTransaction mockDeleteTransaction;

    final fakeTransaction = Transaction(
      id: '1',
      title: 'Café',
      amount: 10.0,
      type: TransactionType.expense,
      date: DateTime(2026, 1, 1),
    );

    setUp(() {
      mockDeleteTransaction = MockDeleteTransaction();
    });

    TransactionDetailBloc buildBloc() =>
        TransactionDetailBloc(mockDeleteTransaction);

    test('estado inicial é TransactionDetailInitial', () {
      expect(buildBloc().state, isA<TransactionDetailInitial>());
    });

    blocTest<TransactionDetailBloc, TransactionDetailState>(
      'emite [TransactionDetailLoaded] ao receber TransactionDetailLoad',
      build: buildBloc,
      act: (bloc) =>
          bloc.add(TransactionDetailLoad(transaction: fakeTransaction)),
      expect: () => [
        isA<TransactionDetailLoaded>().having(
          (s) => s.transaction,
          'transaction',
          fakeTransaction,
        ),
      ],
    );

    blocTest<TransactionDetailBloc, TransactionDetailState>(
      'emite [TransactionDetailDeleting, TransactionDetailDeleted] ao receber TransactionDetailDelete',
      build: buildBloc,
      setUp: () {
        when(mockDeleteTransaction.call(any)).thenAnswer((_) async {});
      },
      act: (bloc) =>
          bloc.add(TransactionDetailDelete(transaction: fakeTransaction)),
      expect: () => [
        isA<TransactionDetailDeleting>(),
        isA<TransactionDetailDeleted>(),
      ],
      verify: (_) {
        verify(mockDeleteTransaction.call('1')).called(1);
      },
    );
  });
}
