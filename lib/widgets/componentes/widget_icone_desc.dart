import 'package:flutter/material.dart';

class WidgetIconeDesc extends StatelessWidget {
  final IconData icone;
  final String descricao;

  const WidgetIconeDesc({key, required this.icone, required this.descricao})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(icone), SizedBox(width: 8), Text(descricao)],
    );
  }
}
