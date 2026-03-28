import 'package:fintrack/core/extensions/num_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../domain/entities/transaction.dart';

class DashboardBalanceCard extends StatelessWidget {
  const DashboardBalanceCard({
    super.key,
    required this.transactions,
    required this.balance,
  });

  final List<Transaction> transactions;
  final double balance;

  String get _transactinosLabel {
    if (transactions.isEmpty) {
      return 'Nenhuma transação registrada';
    }

    if (transactions.length == 1) {
      return '1 Transação registrada';
    }

    return '${transactions.length} transações registradas';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor,
            AppTheme.primaryColor.withValues(alpha: 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saldo Disponível',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            balance.toCurrency,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _transactinosLabel,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
