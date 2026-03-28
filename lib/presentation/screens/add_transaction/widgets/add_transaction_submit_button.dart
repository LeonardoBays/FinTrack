import 'package:fintrack/core/enums/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_transaction_bloc.dart';

class AddTransactionSubmitButton extends StatelessWidget {
  const AddTransactionSubmitButton({
    super.key,
    required this.isEnable,
    required this.transactionType,
  });

  final bool isEnable;
  final TransactionType transactionType;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            transactionType.color,
            transactionType.color.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: isEnable ? () => _onPressed(context) : null,
        icon: isEnable
            ? const Icon(Icons.check_rounded, color: Colors.white)
            : const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
        label: Text(
          isEnable ? 'Salvar Transação' : 'Salvando...',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    context.read<AddTransactionBloc>().add(const AddTransactionSubmit());
  }
}
