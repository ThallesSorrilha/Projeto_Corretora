import 'package:flutter/material.dart';
import 'package:projeto_corretora/dto/dto.dart';

class CampoBuscaOpcoes<T extends DTO> extends StatefulWidget {
  final List<T> opcoes;
  final T? valorSelecionado;
  final bool eObrigatorio;
  final String textoPadrao;
  final String rotulo;
  final void Function(T?)? onChanged;

  const CampoBuscaOpcoes({
    Key? key,
    required this.opcoes,
    this.valorSelecionado,
    this.eObrigatorio = true,
    this.textoPadrao = 'Digite para buscar...',
    required this.rotulo,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CampoBuscaOpcoes<T>> createState() => _CampoBuscaOpcoesState<T>();
}

class _CampoBuscaOpcoesState<T extends DTO> extends State<CampoBuscaOpcoes<T>> {
  T? _selecionado;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _exibirSugestoes = false;

  @override
  void initState() {
    super.initState();
    _selecionado = widget.valorSelecionado;
    if (_selecionado != null) {
      _controller.text = _selecionado!.nome;
    }
  }

  String? _validar(String? texto) {
    if (widget.eObrigatorio && (_selecionado == null)) {
      return 'Selecione uma opção';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final List<T> opcoesFiltradas =
        widget.opcoes
            .where(
              (item) => item.nome.toLowerCase().contains(
                _controller.text.toLowerCase(),
              ),
            )
            .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              labelText: widget.rotulo,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (widget.eObrigatorio && _selecionado == null) {
                return 'Selecione uma opção';
              }
              return null;
            },
            onChanged: (text) {
              setState(() {
                _exibirSugestoes = true;
              });
            },
            onTap: () => setState(() => _exibirSugestoes = true),
          ),
          if (_exibirSugestoes && opcoesFiltradas.isNotEmpty)
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView(
                shrinkWrap: true,
                children:
                    opcoesFiltradas.map((item) {
                      return ListTile(
                        title: Text(item.nome),
                        onTap: () {
                          setState(() {
                            _controller.text = item.nome;
                            _selecionado = item;
                            _exibirSugestoes = false;
                          });
                          widget.onChanged?.call(item);
                        },
                      );
                    }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
