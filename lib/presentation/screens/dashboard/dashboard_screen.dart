import 'package:fintrack/presentation/screens/dashboard/widgets/dashboard_content.dart';
import 'package:flutter/material.dart';

/// Tela principal — exibe o saldo e a lista de transações recentes
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider(
    //   create: (context) => transactionBloc..add(const LoadTransactions()),
    //   child: const DashboardContent(),
    // );

    return const DashboardContent();
  }
}
