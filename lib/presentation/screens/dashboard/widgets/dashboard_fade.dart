import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transaction_bloc.dart';

class DashboardFade extends StatefulWidget {
  const DashboardFade({super.key, required this.child});

  final Widget child;

  @override
  State<DashboardFade> createState() => _DashboardFadeState();
}

class _DashboardFadeState extends State<DashboardFade>
    with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
    context.read<TransactionBloc>().add(const LoadTransactions());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }
}
