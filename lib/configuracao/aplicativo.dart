import 'package:flutter/material.dart';
import '../configuracao/rotas.dart';
import '../widgets/menu.dart';
import 'package:projeto_corretora/widgets/formulario_pessoa.dart';
import 'package:projeto_corretora/widgets/formulario_casa.dart';

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
      },
    );
  }
}
