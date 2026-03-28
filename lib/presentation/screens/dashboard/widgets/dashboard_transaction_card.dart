import 'package:fintrack/core/extensions/num_extension.dart';
import 'package:fintrack/core/routes.dart';
import 'package:fintrack/presentation/screens/transaction_detail/transaction_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/extensions/date_extension.dart';
import '../../../../domain/entities/transaction.dart';
import '../bloc/transaction_bloc.dart';

class DashboardTransactionCard extends StatelessWidget {
  const DashboardTransactionCard({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.isIncome;
    final color = isIncome ? AppTheme.incomeColor : AppTheme.expenseColor;
    final sign = isIncome ? '+' : '-';

    return GestureDetector(
      onTap: () => _onPressed(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF252438),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isIncome
                    ? Icons.arrow_downward_rounded
                    : Icons.arrow_upward_rounded,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    transaction.date.fullDate,
                    style: const TextStyle(fontSize: 12, color: Colors.white38),
                  ),
                ],
              ),
            ),
            Text(
              '$sign ${transaction.amount.toCurrency}',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) async {
    final value = await Navigator.pushNamed(
      context,
      AppRoutes.transactionDetail.route,
      arguments: transaction,
    );

    if (value is TransactionArgDelete && context.mounted) {
      _whenTransactionDeleted(context);
    }
  }

  void _whenTransactionDeleted(BuildContext context) {
    context.read<TransactionBloc>().add(const LoadTransactions());
  }
}
