import 'package:flutter/material.dart';
import 'package:projeto_corretora/widgets/componentes/widget_gaveta.dart';
import '../configuracao/rotas.dart';
import 'componentes/widget_botao_icone_desc.dart';
import 'componentes/widget_icone_desc.dart';

class WidgetMenu extends StatelessWidget {
  const WidgetMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Principal'),
        backgroundColor: Colors.lightGreen,
      ),
      drawer: WidgetGaveta(),
      body: const Center(
        child: Column(
          children: [
            WidgetBotaoDescricao(
              icone: Icons.dark_mode,
              descricao: "Modo Noturno",
            ),
            WidgetIconeDesc(icone: Icons.download, descricao: "Baixar"),
          ],
        ),
      ),
    );
  }
}
