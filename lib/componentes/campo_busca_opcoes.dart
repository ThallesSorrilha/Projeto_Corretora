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
  late List<T> _opcoesFiltradas;
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

  @override
  void didUpdateWidget(covariant CampoBuscaOpcoes<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.opcoes != widget.opcoes) {
      _opcoesFiltradas = List.from(widget.opcoes);
    }
  }

  void _filtrar(String texto) {
    setState(() {
      _opcoesFiltradas =
          widget.opcoes
              .where(
                (item) => item.nome.toLowerCase().contains(texto.toLowerCase()),
              )
              .toList();
      _exibirSugestoes = true;
    });
  }

  String? _validar(String? texto) {
    if (widget.eObrigatorio && (_selecionado == null)) {
      return 'Selecione uma opção';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _opcoesFiltradas =
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
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    labelText: widget.rotulo,
                    border: OutlineInputBorder(),
                  ),
                  validator: _validar,
                  onChanged: (text) {
                    setState(() {
                      _filtrar(text);
                    });
                  },
                  onTap: () => setState(() => _exibirSugestoes = true),
                ),
              ),
            ],
          ),
          if (_exibirSugestoes && _opcoesFiltradas.isNotEmpty)
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView(
                shrinkWrap: true,
                children:
                    _opcoesFiltradas.map((item) {
                      return ListTile(
                        title: Text(item.nome),
                        onTap: () {
                          setState(() {
                            _controller.text = item.nome;
                            _selecionado = item;
                            _exibirSugestoes = false;
                          });
                          widget.onChanged?.call(item);

                          // Seleciona o texto inteiro após um pequeno delay
                          Future.delayed(const Duration(milliseconds: 100), () {
                            _focusNode.requestFocus();
                            _controller.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: _controller.text.length,
                            );
                          });
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
