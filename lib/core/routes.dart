import 'package:fintrack/presentation/screens/transaction_detail/bloc/transaction_detail_bloc.dart';
import 'package:flutter/material.dart';

import '../domain/entities/transaction.dart';
import '../presentation/screens/add_transaction/add_transaction_screen.dart';
import '../presentation/screens/add_transaction/bloc/add_transaction_bloc.dart';
import '../presentation/screens/dashboard/dashboard_screen.dart';
import '../presentation/screens/transaction_detail/transaction_detail_screen.dart';
import 'injection.dart';

enum AppRoutes {
  dashboard('/'),
  transactionDetail('/transaction_detail'),
  addTransaction('/add_transaction');

  final String route;

  const AppRoutes(this.route);

  static AppRoutes fromName(String? screenName) {
    return AppRoutes.values.firstWhere(
      (e) => e.route == screenName,
      orElse: () => dashboard,
    );
  }
}

class Routes {
  static PageRoute router(RouteSettings settings, Injector injector) {
    final appRoute = AppRoutes.fromName(settings.name);

    final Widget screen = switch (appRoute) {
      AppRoutes.dashboard => DashboardScreen(),
      AppRoutes.transactionDetail => TransactionDetailScreen(
        transactionDetailBloc: injector.getIt.get<TransactionDetailBloc>(),
        transaction: settings.arguments as Transaction,
      ),
      AppRoutes.addTransaction => AddTransactionScreen(

        addTransactionBloc: injector.getIt.get<AddTransactionBloc>(),
      ),
    };

    return MaterialPageRoute(builder: (context) => screen, settings: settings);
  }
}
