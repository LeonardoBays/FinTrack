import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/extensions/date_extension.dart';
import '../bloc/add_transaction_bloc.dart';

class AddTransactionDateButton extends StatelessWidget {
  const AddTransactionDateButton({
    super.key,
    required this.isEnable,
    required this.selectedDate,
  });

  final bool isEnable;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => _pickDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF252438),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_rounded,
              color: Colors.white38,
              size: 20,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data',
                  style: TextStyle(color: Colors.white60, fontSize: 12),
                ),
                const SizedBox(height: 2),
                Text(
                  selectedDate.fullDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.chevron_right_rounded, color: Colors.white38),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2026),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.dark(
            primary: AppTheme.primaryColor,
            surface: const Color(0xFF252438),
          ),
        ),
        child: child!,
      ),
    );
    if (date != null && context.mounted) {
      _onDateSelected(context, date);
    }
  }

  void _onDateSelected(BuildContext context, DateTime date) {

    final dtNow = DateTime.now().copyWith(year: date.year, month: date.month, day: date.day);

    context.read<AddTransactionBloc>().add(AddTransactionDate(dtNow));
  }
}
