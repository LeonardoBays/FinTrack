import 'package:fintrack/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../add_transaction/add_transaction_screen.dart';
import '../bloc/transaction_bloc.dart';

class DashboardFab extends StatelessWidget {
  const DashboardFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _onPressed(context),
      icon: const Icon(Icons.add_rounded),
      label: const Text(
        'Nova Transação',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  void _onPressed(BuildContext context) async {
    final value = await Navigator.pushNamed(
      context,
      AppRoutes.addTransaction.route,
    );

    if (value is TransactionArgSave && context.mounted) {
      _whenTransactionSaved(context);
    }
  }

  void _whenTransactionSaved(BuildContext context) {
    context.read<TransactionBloc>().add(const LoadTransactions());
  }
}
