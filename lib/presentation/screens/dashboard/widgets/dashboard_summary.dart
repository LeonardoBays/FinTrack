import 'package:fintrack/core/extensions/num_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import 'dashboard_summary_card.dart';

class DashboardSummary extends StatelessWidget {
  const DashboardSummary({
    super.key,
    required this.totalIncome,
    required this.totalExpense,
  });

  final double totalIncome;
  final double totalExpense;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DashboardSummaryCard(
            label: 'Receitas',
            value: totalIncome.toCurrency,
            icon: Icons.arrow_downward_rounded,
            color: AppTheme.incomeColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DashboardSummaryCard(
            label: 'Despesas',
            value: totalExpense.toCurrency,
            icon: Icons.arrow_upward_rounded,
            color: AppTheme.expenseColor,
          ),
        ),
      ],
    );
  }
}
