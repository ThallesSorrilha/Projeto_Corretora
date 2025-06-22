import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EntradaNumerica extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final FormFieldValidator<String>? validator;

  const EntradaNumerica({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.number,
    this.inputFormatters,
    this.hintText,
    this.validator,
  });

  @override
  State<EntradaNumerica> createState() => _EntradaNumericaState();
}

class _EntradaNumericaState extends State<EntradaNumerica> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          border: OutlineInputBorder(),
        ),
        validator: widget.validator,
      ),
    );
  }
}
