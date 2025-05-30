import 'package:flutter/material.dart';
import 'package:projeto_corretora/widgets/widget_casa2.dart';
import '../configuracao/rotas.dart';
import '../widgets/widget_menu.dart';
import '../widgets/widget_casa_cadastro.dart';

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
        Rotas.home: (context) => FormularioPessoa(),
        //Rotas.home: (context) => const WidgetMenu(),
        Rotas.login: (context) => const WidgetMenu(),
        Rotas.usuarioCadastro: (context) => const WidgetMenu(),
        Rotas.usuario: (context) => const WidgetMenu(),
        Rotas.logout: (context) => const WidgetMenu(),
        Rotas.casaBuscar: (context) => const WidgetMenu(),
        Rotas.casaCadastrar: (context) => WidgetCasaCadastro(),
      },
    );
  }
}
