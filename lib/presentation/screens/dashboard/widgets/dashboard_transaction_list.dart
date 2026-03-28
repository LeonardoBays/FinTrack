import 'package:fintrack/domain/entities/transaction.dart';
import 'package:fintrack/presentation/screens/dashboard/widgets/dashboard_transaction_card.dart';
import 'package:flutter/material.dart';

import 'dashboard_empty_transactions.dart';

class DashboardTransactionList extends StatelessWidget {
  const DashboardTransactionList({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transações Recentes',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        if (transactions.isEmpty)
          const DashboardEmptyTransactions()
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return DashboardTransactionCard(transaction: transaction);
            },
          ),
      ],
    );
  }
}
