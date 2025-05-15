import 'package:flutter/material.dart';

class WidgetBotaoDescricao extends StatelessWidget {
  final IconData icone;
  final String descricao;
  final VoidCallback? pressionado;

  const WidgetBotaoDescricao({
    key,
    required this.icone,
    required this.descricao,
    this.pressionado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressionado,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Text(descricao), SizedBox(width: 8), Icon(icone)],
      ),
    );
  }
}
