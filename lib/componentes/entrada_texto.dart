import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EntradaTexto extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final int maxLinhas;
  final bool censura;

  const EntradaTexto({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.hintText,
    this.validator,
    this.maxLinhas = 1,
    this.censura = false,
  });

  @override
  State<EntradaTexto> createState() => _EntradaTextoState();
}

class _EntradaTextoState extends State<EntradaTexto> {
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
        maxLines: widget.maxLinhas,
        obscureText: widget.censura,
      ),
    );
  }
}
