import 'package:fintrack/core/extensions/date_extension.dart';
import 'package:fintrack/domain/entities/transaction.dart';
import 'package:flutter/material.dart';

import 'transaction_detail_info.dart';

class TransactionDetailData extends StatelessWidget {
  const TransactionDetailData({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionDetailInfo(
          icon: Icons.label_important_outline_rounded,
          label: 'Título',
          value: transaction.title,
        ),
        TransactionDetailInfo(
          icon: Icons.calendar_today_rounded,
          label: 'Data',
          value: transaction.date.fullDate,
        ),
        TransactionDetailInfo(
          icon: Icons.tag_rounded,
          label: 'ID da transação',
          value: transaction.id,
        ),
      ],
    );
  }
}
