import 'package:fintrack/core/enums/transaction_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' hide Transaction;
import 'package:fintrack/data/datasources/database_helper.dart';
import 'package:fintrack/data/repositories/sqlite_transaction_repository.dart';
import 'package:fintrack/domain/entities/transaction.dart';

void main() {
  /// Inicializa FFI para rodar SQLite no desktop/testes
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('SqliteTransactionRepository tests (with in-memory DB)', () {
    late Database db;
    late DatabaseHelper mockDbHelper;
    late SqliteTransactionRepository repository;

    setUp(() async {
      db = await databaseFactory.openDatabase(inMemoryDatabasePath,
          options: OpenDatabaseOptions(
            version: 1,
            onCreate: (Database db, int version) async {
              await db.execute('''
                CREATE TABLE transactions (
                  id TEXT PRIMARY KEY,
                  title TEXT NOT NULL,
                  amount REAL NOT NULL,
                  type TEXT NOT NULL,
                  date TEXT NOT NULL
                )
              ''');
            },
          ));

      mockDbHelper = _FakeDatabaseHelper(db);
      repository = SqliteTransactionRepository(mockDbHelper);
    });

    tearDown(() async {
      await db.close();
    });

    test('getTransactions retorna vazio quando db estiver vazio', () async {
      final res = await repository.getTransactions();
      expect(res, isEmpty);
    });

    test('addTransaction insere a transação no banco de dados', () async {
      final t = Transaction(
        id: '99',
        title: 'Lanche',
        amount: 30.0,
        type: TransactionType.expense,
        date: DateTime(2026, 1, 1),
      );

      await repository.addTransaction(t);

      final query = await db.query('transactions');
      expect(query.length, equals(1));
      expect(query.first['title'], equals('Lanche'));
      expect(query.first['amount'], equals(30.0));
      expect(query.first['type'], equals('expense'));
    });

    test('getTransactions retorna transações corretamente convertidas', () async {
      await db.insert('transactions', {
        'id': 'abc',
        'title': 'Salário',
        'amount': 2000.0,
        'type': 'income',
        'date': DateTime(2026, 3, 1).toIso8601String(),
      });

      final items = await repository.getTransactions();
      expect(items.length, equals(1));
      expect(items.first.title, equals('Salário'));
      expect(items.first.isIncome, isTrue);
    });

    test('deleteTransaction remove transação apenas pelo ID', () async {
      await db.insert('transactions', {
        'id': '111',
        'title': 'A',
        'amount': 10,
        'type': 'income',
        'date': DateTime.now().toIso8601String(),
      });
      await db.insert('transactions', {
        'id': '222',
        'title': 'B',
        'amount': 20,
        'type': 'expense',
        'date': DateTime.now().toIso8601String(),
      });

      await repository.deleteTransaction('111');

      final items = await repository.getTransactions();
      expect(items.length, equals(1));
      expect(items.first.id, equals('222'));
    });
  });
}

class _FakeDatabaseHelper implements DatabaseHelper {
  final Database _db;
  _FakeDatabaseHelper(this._db);

  @override
  Future<Database> get database async => _db;
  
  // ignore: no_logic_in_create_state, unused_element
  @override
  Future<void> close() async {}
}
