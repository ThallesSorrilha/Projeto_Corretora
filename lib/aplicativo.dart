import 'package:flutter/material.dart';
import 'package:projeto_corretora/telas/form_cidade.dart';
import 'package:projeto_corretora/telas/form_estado.dart';
import 'configuracao/rotas.dart';
import 'telas/menu.dart';
import 'package:projeto_corretora/telas/form_pessoa.dart';
import 'package:projeto_corretora/telas/form_casa.dart';

class Aplicativo extends StatelessWidget {
  const Aplicativo({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aula Widget',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      initialRoute: Rotas.home,
      routes: {
        Rotas.home: (context) => const WidgetMenu(),
        Rotas.login: (context) => const WidgetMenu(),
        Rotas.cadastrarUsuario: (context) => FormPessoa(),
        Rotas.usuario: (context) => const WidgetMenu(),
        Rotas.logout: (context) => const WidgetMenu(),
        Rotas.buscarCasa: (context) => const WidgetMenu(),
        Rotas.cadastrarCasa: (context) => FormCasa(),
        Rotas.cadastrarEstado: (context) => FormEstado(),
        Rotas.cadastrarCidade: (context) => FormCidade(),
      },
    );
  }
}
