import 'package:flutter/material.dart';

import '../app_theme.dart';

enum TransactionType {
  income,
  expense;

  String get label {
    return switch (this) {
      TransactionType.income => 'Receita',
      TransactionType.expense => 'Despesa',
    };
  }

  Color get color {
    return switch (this) {
      TransactionType.income => AppTheme.incomeColor,
      TransactionType.expense => AppTheme.expenseColor,
    };
  }

  IconData get icon {
    return switch (this) {
      TransactionType.income => Icons.arrow_downward_rounded,
      TransactionType.expense => Icons.arrow_upward_rounded,
    };
  }
}
