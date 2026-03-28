import 'package:fintrack/presentation/screens/transaction_detail/bloc/transaction_detail_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/database_helper.dart';
import '../data/repositories/sqlite_transaction_repository.dart';
import '../domain/repositories/transaction_repository.dart';
import '../domain/usecases/add_transaction.dart';
import '../domain/usecases/delete_transaction.dart';
import '../domain/usecases/get_balance.dart';
import '../domain/usecases/get_transactions.dart';
import '../presentation/screens/add_transaction/bloc/add_transaction_bloc.dart';
import '../presentation/screens/dashboard/bloc/transaction_bloc.dart';

abstract class Injector {
  Injector(this.getIt);

  late final GetIt getIt;

  void dispose();
}

final class InjectorImpl extends Injector {
  InjectorImpl._(super.getIt);

  static Future<Injector> initializeDependencies() async {
    final getIt = GetIt.instance;

    getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

    getIt.registerLazySingleton<TransactionRepository>(
      () => SqliteTransactionRepository(getIt<DatabaseHelper>()),
    );

    getIt.registerFactory(() => AddTransaction(getIt<TransactionRepository>()));
    getIt.registerFactory(
      () => DeleteTransaction(getIt<TransactionRepository>()),
    );
    getIt.registerFactory(
      () => GetTransactions(getIt<TransactionRepository>()),
    );
    getIt.registerFactory(() => GetBalance(getIt<TransactionRepository>()));

    getIt.registerFactory(
      () => TransactionBloc(
        getTransactions: getIt<GetTransactions>(),
        addTransaction: getIt<AddTransaction>(),
        getBalance: getIt<GetBalance>(),
      ),
    );

    getIt.registerFactory(
      () => TransactionDetailBloc(getIt<DeleteTransaction>()),
    );

    getIt.registerFactory(() => AddTransactionBloc(getIt<AddTransaction>()));

    return InjectorImpl._(getIt);
  }

  @override
  void dispose() {
    Future.wait([]);
  }
}
