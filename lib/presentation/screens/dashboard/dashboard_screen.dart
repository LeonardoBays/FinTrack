import 'package:fintrack/presentation/screens/dashboard/bloc/transaction_bloc.dart';
import 'package:fintrack/presentation/screens/dashboard/widgets/dashboard_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Tela principal — exibe o saldo e a lista de transações recentes
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.transactionBloc});

  final TransactionBloc transactionBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => transactionBloc..add(const LoadTransactions()),
      child: const DashboardContent(),
    );
  }
}
