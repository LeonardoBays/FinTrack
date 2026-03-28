import 'package:fintrack/presentation/screens/add_transaction/bloc/add_transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/transaction_type.dart';

class AddTransactionTypeButton extends StatelessWidget {
  const AddTransactionTypeButton({
    super.key,
    required this.transactionType,
    required this.selectedTransactionType,
  });

  final TransactionType transactionType;
  final TransactionType selectedTransactionType;

  bool get _isSelected => transactionType == selectedTransactionType;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onPressed(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: _isSelected
                ? transactionType.color.withValues(alpha: 0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: _isSelected
                ? Border.all(
                    color: transactionType.color.withValues(alpha: 0.5),
                  )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                transactionType.icon,
                color: _isSelected ? transactionType.color : Colors.white38,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                transactionType.label,
                style: TextStyle(
                  color: _isSelected ? transactionType.color : Colors.white38,
                  fontWeight: _isSelected ? FontWeight.w700 : FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    context.read<AddTransactionBloc>().add(
      AddTransactionToggle(transactionType),
    );
  }
}
