import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/transaction_bloc.dart';
import 'dashboard_balance_card.dart';
import 'dashboard_summary.dart';
import 'dashboard_transaction_list.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key, required this.state});

  final TransactionLoaded state;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _onRefresh(context),
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          20,
          8,
          20,
          50 + MediaQuery.of(context).padding.bottom,
        ),
        children: [
          DashboardBalanceCard(
            transactions: state.transactions,
            balance: state.balance,
          ),
          const SizedBox(height: 24),
          DashboardSummary(
            totalExpense: state.totalExpense,
            totalIncome: state.totalIncome,
          ),
          const SizedBox(height: 28),
          DashboardTransactionList(transactions: state.transactions),
        ],
      ),
    );
  }

  void _onRefresh(BuildContext context) {
    context.read<TransactionBloc>().add(const LoadTransactions());
  }
}
