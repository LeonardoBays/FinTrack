import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';

class TransactionDetailDeleteDialog extends StatelessWidget {
  const TransactionDetailDeleteDialog({super.key, required this.onConfirm});

  final Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF252438),
      title: const Text(
        'Excluir Transação',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: const Text(
        'Tem certeza que deseja excluir esta transação? '
        'Essa ação não pode ser desfeita.',
        style: TextStyle(color: Colors.white70),
      ),
      actions: [
        TextButton(
          onPressed: () => _onCancelPressed(context),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.white54),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.expenseColor,
          ),
          onPressed: () => _onConfirmPressed(context),
          child: const Text(
            'Excluir',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _onCancelPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onConfirmPressed(BuildContext context) {
    Navigator.pop(context);
    onConfirm();
  }
}
