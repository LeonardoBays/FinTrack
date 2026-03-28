import 'package:flutter/material.dart';

class DashboardTitle extends StatelessWidget {
  const DashboardTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'FinTrack',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 22,
        letterSpacing: 1,
      ),
    );
  }
}
