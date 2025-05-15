import 'package:flutter/material.dart';
import '../configuracao/rotas.dart';
import '../widgets/widget_menu.dart';

class Aplicativo extends StatelessWidget{
  const Aplicativo({key}) : super(key: key);
  
  @override 
  Widget build(BuildContext context){
    return MaterialApp( 
      title: 'Aula Widget',
      theme: ThemeData( 
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Rotas.home,
      routes: {
        Rotas.home :(context) => const WidgetMenu(),
      },
    );
  }
}