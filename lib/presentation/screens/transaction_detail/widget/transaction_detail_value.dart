import 'package:fintrack/core/extensions/num_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../domain/entities/transaction.dart';

class TransactionDetailValue extends StatelessWidget {
  const TransactionDetailValue({super.key, required this.transaction});

  final Transaction transaction;

  Color get _transactionColor {
    final isIncome = transaction.isIncome;
    return isIncome ? AppTheme.incomeColor : AppTheme.expenseColor;
  }

  IconData get _transactionIcon {
    final isIncome = transaction.isIncome;
    return isIncome ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded;
  }

  String get _transactionLabel {
    final isIncome = transaction.isIncome;
    return isIncome ? 'RECEITA' : 'DESPESA';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _transactionColor.withValues(alpha: 0.8),
            _transactionColor.withValues(alpha: 0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(_transactionIcon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            _transactionLabel,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            transaction.amount.toCurrency,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}
