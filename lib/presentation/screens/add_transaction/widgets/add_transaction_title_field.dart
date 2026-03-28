import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_transaction_bloc.dart';

class AddTransactionTitleField extends StatefulWidget {
  const AddTransactionTitleField({
    super.key,
    required this.value,
    this.error,
    required this.isEnable,
  });

  final String value;
  final String? error;
  final bool isEnable;

  @override
  State<AddTransactionTitleField> createState() =>
      _AddTransactionTitleFieldState();
}

class _AddTransactionTitleFieldState extends State<AddTransactionTitleField> {
  late String? _error;
  late bool _isEnable;

  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    _error = widget.error;
    _isEnable = widget.isEnable;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AddTransactionTitleField oldWidget) {
    if (_controller.text != widget.value) {
      _controller.text = widget.value;
    }

    if (_error != widget.error) {
      _error = widget.error;
    }

    if (_isEnable != widget.isEnable) {
      _isEnable = widget.isEnable;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      textCapitalization: TextCapitalization.sentences,
      enabled: _isEnable,
      onChanged: _onChanged,
      decoration: InputDecoration(
        labelText: 'Título',
        hintText: 'Ex: Salário, Mercado...',
        prefixIcon: Icon(Icons.label_important_outline_rounded, color: Colors.white38),
        errorText: _error,
      ),
    );
  }

  void _onChanged(String value) {
    context.read<AddTransactionBloc>().add(AddTransactionTitle(value));
  }
}
