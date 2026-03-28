import 'package:fintrack/presentation/screens/transaction_detail/widget/transaction_detail_body.dart';
import 'package:fintrack/presentation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/transaction_detail_bloc.dart';
import '../transaction_detail_screen.dart';

class TransactionDetailContent extends StatelessWidget {
  const TransactionDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: BlocConsumer<TransactionDetailBloc, TransactionDetailState>(
        listener: _listener,
        builder: (context, state) {
          if (state is TransactionDetailLoaded) {
            return TransactionDetailBody(state: state);
          }

          return const CustomLoading();
        },
      ),
    );
  }

  void _listener(BuildContext context, TransactionDetailState state) {
    if (state is TransactionDetailDeleted) {
      _onDeleteCompleted(context);
    }
  }

  void _onDeleteCompleted(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Transação excluída')));

    Navigator.pop(context, const TransactionArgDelete());
  }
}
