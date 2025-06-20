import 'package:flutter/material.dart';
import 'package:projeto_corretora/telas/formulario_cidade.dart';
import 'package:projeto_corretora/telas/formulario_estado.dart';
import 'configuracao/rotas.dart';
import 'telas/menu.dart';
import 'package:projeto_corretora/telas/formulario_pessoa.dart';
import 'package:projeto_corretora/telas/formulario_casa.dart';

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
        Rotas.usuarioCadastro: (context) => FormularioPessoa(),
        Rotas.usuario: (context) => const WidgetMenu(),
        Rotas.logout: (context) => const WidgetMenu(),
        Rotas.casaBuscar: (context) => const WidgetMenu(),
        Rotas.casaCadastrar: (context) => FormularioCasa(),
        Rotas.estadoCadastrar: (context) => FormularioEstado(),
        Rotas.cidadeCadastrar: (context) => FormularioCidade(),
      },
    );
  }
}
