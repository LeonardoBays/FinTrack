import 'package:fintrack/presentation/screens/transaction_detail/bloc/transaction_detail_bloc.dart';
import 'package:fintrack/presentation/screens/transaction_detail/widget/transaction_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/transaction.dart';

/// Tela de detalhes de uma transação específica
class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({
    super.key,
    required this.transactionDetailBloc,
    required this.transaction,
  });

  final TransactionDetailBloc transactionDetailBloc;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return transactionDetailBloc
          ..add(TransactionDetailLoad(transaction: transaction));
      },
      child: const TransactionDetailContent(),
    );
  }
}

class TransactionArgDelete {
  const TransactionArgDelete();
}
