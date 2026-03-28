import 'package:flutter/material.dart';

class DashboardEmptyTransactions extends StatelessWidget {
  const DashboardEmptyTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhuma transação ainda',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Toque no botão abaixo para adicionar',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.25),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
