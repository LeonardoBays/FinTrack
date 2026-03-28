import 'package:fintrack/presentation/screens/transaction_detail/widget/transaction_detail_delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/transaction.dart';
import '../bloc/transaction_detail_bloc.dart';

class TransactionDetailDeleteButton extends StatelessWidget {
  const TransactionDetailDeleteButton({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton.icon(
        onPressed: () => _showDialogDelete(context),
        icon: Icon(Icons.delete_outline),
        label: Text('Deletar'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  void _showDialogDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return TransactionDetailDeleteDialog(
          onConfirm: () => _onDeleteConfirm(context),
        );
      },
    );
  }

  void _onDeleteConfirm(BuildContext context) {
    context.read<TransactionDetailBloc>().add(
      TransactionDetailDelete(transaction: transaction),
    );
  }
}
