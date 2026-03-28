import 'package:fintrack/presentation/screens/dashboard/widgets/dashboard_fade.dart';
import 'package:fintrack/presentation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/custom_error.dart';
import '../bloc/transaction_bloc.dart';
import 'dashboard_body.dart';
import 'dashboard_fab.dart';
import 'dashboard_title.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const DashboardTitle()),
      body: DashboardFade(
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionError) {
              return CustomError(message: state.message);
            }

            if (state is TransactionLoaded) {
              return DashboardBody(state: state);
            }

            return const CustomLoading();
          },
        ),
      ),
      floatingActionButton: const DashboardFab(),
    );
  }
}
