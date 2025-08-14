import 'package:flutter/material.dart';
import 'package:projeto_corretora/componentes/gaveta.dart';

class Layout extends StatelessWidget {
  final Widget body;

  const Layout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mãe Joana Imóveis'),
        backgroundColor: Colors.lightGreen,
      ),
      drawer: WidgetGaveta(),
      body: body,
    );
  }
}
