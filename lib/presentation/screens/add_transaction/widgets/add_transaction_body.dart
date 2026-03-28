import 'package:fintrack/presentation/screens/add_transaction/bloc/add_transaction_bloc.dart';
import 'package:flutter/material.dart';

import 'add_transaction_amout_field.dart';
import 'add_transaction_date_button.dart';
import 'add_transaction_submit_button.dart';
import 'add_transaction_title_field.dart';
import 'add_transaction_type_toggle.dart';

class AddTransactionBody extends StatelessWidget {
  const AddTransactionBody({super.key, required this.state});

  final AddTransactionState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AddTransactionTypeToggle(
            selectedTransactionType: state.transactionType,
          ),
          const SizedBox(height: 24),
          AddTransactionTitleField(
            isEnable: state is! AddTransactionSaving,
            value: state.title,
            error: state.titleError,
          ),
          const SizedBox(height: 16),
          AddTransactionAmoutField(
            isEnable: state is! AddTransactionSaving,
            value: state.amount,
            error: state.amountError,
          ),
          const SizedBox(height: 16),
          AddTransactionDateButton(
            isEnable: state is! AddTransactionSaving,
            selectedDate: state.date ?? DateTime.now(),
          ),
          const SizedBox(height: 36),
          AddTransactionSubmitButton(
            isEnable: state is! AddTransactionSaving,
            transactionType: state.transactionType,
          ),
        ],
      ),
    );
  }
}
