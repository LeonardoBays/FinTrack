import 'package:fintrack/presentation/screens/add_transaction/bloc/add_transaction_bloc.dart';
import 'package:fintrack/presentation/screens/add_transaction/widgets/add_transaction_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key, required this.addTransactionBloc});

  final AddTransactionBloc addTransactionBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => addTransactionBloc..add(const AddTransactionLoad()),
      child: const AddTransactionContent(),
    );
  }
}

class TransactionArgSave {
  const TransactionArgSave();
}
