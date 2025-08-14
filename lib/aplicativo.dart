import 'package:flutter/material.dart';
import 'package:projeto_corretora/telas/busca_casa.dart';
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
        Rotas.cadastrarUsuario: (context) => const FormPessoa(),
        Rotas.usuario: (context) => const WidgetMenu(),
        Rotas.logout: (context) => const WidgetMenu(),
        Rotas.buscarCasa: (context) => const BuscaCasa(),
        Rotas.cadastrarCasa: (context) => const FormCasa(),
        Rotas.cadastrarEstado: (context) => const FormEstado(),
        Rotas.cadastrarCidade: (context) => const FormCidade(),
      },
    );
  }
}
