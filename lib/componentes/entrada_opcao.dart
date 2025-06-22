import 'package:flutter/material.dart';

class EntradaOpcao extends StatefulWidget {
  final List<String> opcoes;
  final String? valorSelecionado;
  final FormFieldValidator<String>? validator;
  final String textoPadrao;
  final String rotulo;
  final void Function(String?)? onChanged;

  const EntradaOpcao({
    Key? key,
    required this.opcoes,
    this.valorSelecionado,
    this.validator,
    this.textoPadrao = 'Escolha uma opção',
    required this.rotulo,
    this.onChanged,
  }) : super(key: key);

  @override
  State<EntradaOpcao> createState() => _EntradaOpcaoState();
}

class _EntradaOpcaoState extends State<EntradaOpcao> {
  late List<String> _opcoesCampo;
  String? _valorSelecionado;

  @override
  void initState() {
    super.initState();
    _opcoesCampo = List.from(widget.opcoes);
    _valorSelecionado = widget.valorSelecionado;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: widget.rotulo,
          border: OutlineInputBorder(),
        ),
        isExpanded: true,
        value: _valorSelecionado,
        validator: widget.validator,
        onChanged: (String? novoValor) {
          setState(() {
            _valorSelecionado = novoValor;
          });
          widget.onChanged?.call(novoValor);
        },
        items: [
          DropdownMenuItem<String>(value: null, child: Text(widget.textoPadrao)),
          ..._opcoesCampo.map(
            (op) => DropdownMenuItem<String>(value: op, child: Text(op)),
          ),
        ],
      ),
    );
  }
}