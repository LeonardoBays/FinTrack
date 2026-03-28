import 'package:fintrack/presentation/screens/transaction_detail/widget/transaction_detail_delete_button.dart';
import 'package:fintrack/presentation/screens/transaction_detail/widget/transaction_detail_value.dart';
import 'package:flutter/material.dart';

import '../bloc/transaction_detail_bloc.dart';
import 'transaction_detail_data.dart';

class TransactionDetailBody extends StatelessWidget {
  const TransactionDetailBody({super.key, required this.state});

  final TransactionDetailLoaded state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).padding.add(EdgeInsets.all(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 32,
        children: [
          TransactionDetailValue(transaction: state.transaction),
          TransactionDetailData(transaction: state.transaction),
          TransactionDetailDeleteButton(transaction: state.transaction),
        ],
      ),
    );
  }
}
