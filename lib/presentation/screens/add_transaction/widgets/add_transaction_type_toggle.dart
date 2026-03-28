import 'package:flutter/material.dart';

import '../../../../core/enums/transaction_type.dart';
import 'add_transaction_type_button.dart';

class AddTransactionTypeToggle extends StatelessWidget {
  const AddTransactionTypeToggle({
    super.key,
    required this.selectedTransactionType,
  });

  final TransactionType selectedTransactionType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF252438),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          AddTransactionTypeButton(
            transactionType: TransactionType.income,
            selectedTransactionType: selectedTransactionType,
          ),
          AddTransactionTypeButton(
            transactionType: TransactionType.expense,
            selectedTransactionType: selectedTransactionType,
          ),
        ],
      ),
    );
  }
}
