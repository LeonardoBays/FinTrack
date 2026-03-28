import 'package:fintrack/presentation/screens/add_transaction/widgets/add_transaction_body.dart';
import 'package:fintrack/presentation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_transaction_screen.dart';
import '../bloc/add_transaction_bloc.dart';

class AddTransactionContent extends StatelessWidget {
  const AddTransactionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova Transação',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocConsumer<AddTransactionBloc, AddTransactionState>(
        listener: _listener,
        builder: (context, state) {
          if (state is AddTransactionInitial ||
              state is AddTransactionLoading) {
            return const CustomLoading();
          }

          return AddTransactionBody(state: state);
        },
      ),
    );
  }

  void _listener(BuildContext context, AddTransactionState state) {
    if (state is AddTransactionSaved) {
      _onSavedCompleted(context);
    }
  }

  void _onSavedCompleted(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Transação salva!')));

    Navigator.pop(context, const TransactionArgSave());
  }
}
