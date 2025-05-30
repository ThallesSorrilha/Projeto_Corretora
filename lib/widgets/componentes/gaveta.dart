import 'package:flutter/material.dart';
import '../../configuracao/rotas.dart';

class WidgetGaveta extends StatelessWidget {
  const WidgetGaveta({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget criarMenu({
      required IconData icone,
      required String rotulo,
      required String rota,
    }) {
      return ListTile(
        leading: Icon(icone),
        title: Text(rotulo),
        onTap: () => Navigator.pushNamed(context, rota),
      );
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.lightGreen),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          criarMenu(
            icone: Icons.search,
            rotulo: 'Buscar Casa',
            rota: Rotas.casaBuscar,
          ),
          criarMenu(
            icone: Icons.home_work,
            rotulo: 'Cadastrar Casa',
            rota: Rotas.casaCadastrar,
          ),
          criarMenu(
            icone: Icons.account_circle,
            rotulo: 'Minha Conta',
            rota: Rotas.usuario,
          ),
          criarMenu(icone: Icons.logout, rotulo: 'Logout', rota: Rotas.logout),
          criarMenu(
            icone: Icons.add_reaction,
            rotulo: 'Cadastrar Usuário',
            rota: Rotas.usuarioCadastro,
          ),
        ],
      ),
    );
  }
}
