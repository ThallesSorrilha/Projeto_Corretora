import 'package:flutter/material.dart';
import 'package:projeto_corretora/dto/dto.dart';

class EntradaSelect<T extends DTO> extends StatefulWidget {
  final List<T> opcoes;
  final T? valorSelecionado;
  final FormFieldValidator<T>? validator;
  final String textoPadrao;
  final String rotulo;
  final void Function(T?)? onChanged;

  const EntradaSelect({
    Key? key,
    required this.opcoes,
    this.valorSelecionado,
    this.validator,
    this.textoPadrao = 'Escolha uma opção',
    required this.rotulo,
    this.onChanged,
  }) : super(key: key);

  @override
  State<EntradaSelect<T>> createState() => _EntradaSelectState<T>();
}

class _EntradaSelectState<T extends DTO> extends State<EntradaSelect<T>> {
  late List<T> _opcoesCampo;
  T? _valorSelecionado;

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
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          labelText: widget.rotulo,
          border: OutlineInputBorder(),
        ),
        isExpanded: true,
        value: _valorSelecionado,
        validator: widget.validator,
        onChanged: (T? novoValor) {
          setState(() {
            _valorSelecionado = novoValor;
          });
          widget.onChanged?.call(novoValor);
        },
        items: [
          DropdownMenuItem<T>(value: null, child: Text(widget.textoPadrao)),
          ..._opcoesCampo.map(
            (op) => DropdownMenuItem<T>(value: op, child: Text(op.nome)),
          ),
        ],
      ),
    );
  }
}
