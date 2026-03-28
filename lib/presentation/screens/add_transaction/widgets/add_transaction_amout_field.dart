import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_transaction_bloc.dart';

class AddTransactionAmoutField extends StatefulWidget {
  const AddTransactionAmoutField({
    super.key,
    required this.value,
    this.error,
    required this.isEnable,
  });

  final String value;
  final String? error;
  final bool isEnable;

  @override
  State<AddTransactionAmoutField> createState() =>
      _AddTransactionAmoutFieldState();
}

class _AddTransactionAmoutFieldState extends State<AddTransactionAmoutField> {
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
  void didUpdateWidget(covariant AddTransactionAmoutField oldWidget) {
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
      inputFormatters: <TextInputFormatter>[
        CurrencyTextInputFormatter.currency(locale: 'pt_BR', symbol: 'R\$'),
      ],
      keyboardType: TextInputType.number,
      enabled: _isEnable,
      onChanged: _onChanged,
      decoration: InputDecoration(
        labelText: 'Valor (R\$)',
        hintText: '0,00',
        prefixIcon: Icon(Icons.attach_money_rounded, color: Colors.white38),
        errorText: _error,
      ),
    );
  }

  void _onChanged(String value) {
    context.read<AddTransactionBloc>().add(AddTransactionAmount(value));
  }
}
