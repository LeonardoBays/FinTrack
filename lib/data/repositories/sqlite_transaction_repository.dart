import 'package:sqflite/sqflite.dart' hide Transaction;
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/database_helper.dart';
import '../models/transaction_model.dart';

/// Repositório concreto usando SQlite como banco de dados local.
class SqliteTransactionRepository implements TransactionRepository {
  final DatabaseHelper dbHelper;

  SqliteTransactionRepository(this.dbHelper);

  @override
  Future<List<Transaction>> getTransactions() async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'transactions',
      orderBy: 'date DESC',
    );

    return maps.map((map) => TransactionModel.fromMap(map)).toList();
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    final db = await dbHelper.database;
    final transactionModel = TransactionModel(
      id: transaction.id,
      title: transaction.title,
      amount: transaction.amount,
      type: transaction.type,
      date: transaction.date,
    );

    await db.insert(
      'transactions',
      transactionModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await dbHelper.database;
    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
