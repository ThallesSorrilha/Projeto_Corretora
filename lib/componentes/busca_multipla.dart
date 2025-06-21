import 'package:flutter/material.dart';
import 'package:projeto_corretora/componentes/campo_busca_opcoes.dart';
import 'package:projeto_corretora/dto/dto.dart';

/// Widget reutilizável para seleção múltipla com busca.
/// T recebe um tipo que herda de DTO e sobrescreve toString() ou implementa nome.
class CampoBuscaMultipla<T extends DTO> extends StatefulWidget {
  final List<T> opcoes;
  final String rotulo;
  final String textoPadrao;
  final String? mensagemValidacao;
  final void Function(List<T> selecionados)? onChanged;

  const CampoBuscaMultipla({
    super.key,
    required this.opcoes,
    required this.rotulo,
    required this.textoPadrao,
    this.mensagemValidacao,
    this.onChanged,
  });

  @override
  State<CampoBuscaMultipla<T>> createState() => _CampoBuscaMultiplaState<T>();
}

class _CampoBuscaMultiplaState<T extends DTO> extends State<CampoBuscaMultipla<T>> {
  final List<T> _selecionados = [];

  void _adicionarItem(T item) {
    if (!_selecionados.contains(item)) {
      setState(() {
        _selecionados.add(item);
      });
      widget.onChanged?.call(_selecionados);
    }
  }

  void _removerItem(T item) {
    setState(() {
      _selecionados.remove(item);
    });
    widget.onChanged?.call(_selecionados);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CampoBuscaOpcoes<T>(
          opcoes: widget.opcoes,
          rotulo: widget.rotulo,
          textoPadrao: widget.textoPadrao,
          eObrigatorio: false,
          onChanged: (item) {
            if (item != null) _adicionarItem(item);
          },
        ),
        const SizedBox(height: 8),
        Text(
          widget.rotulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        ..._selecionados.map(
          (item) => ListTile(
            title: Text(item.nome),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removerItem(item),
            ),
          ),
        )
      ],
    );
  }
}