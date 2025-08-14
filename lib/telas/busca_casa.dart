import 'package:flutter/material.dart';
import 'package:projeto_corretora/componentes/card_casa.dart';
import 'package:projeto_corretora/componentes/layout.dart';
import 'package:projeto_corretora/dao/dao_casa.dart';
import 'package:projeto_corretora/dto/dto_casa.dart';

class BuscaCasa extends StatefulWidget {
  const BuscaCasa({Key? key}) : super(key: key);

  @override
  State<BuscaCasa> createState() => _BuscaCasaState();
}

class _BuscaCasaState extends State<BuscaCasa> {
  final CasaDao _casaDao = CasaDao();
  List<CasaDTO> _listaCasas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarCasas();
  }

  Future<void> _carregarCasas() async {
    try {
      final casas = await _casaDao.consultarTodos();
      setState(() {
        _listaCasas = casas;
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar casas: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Casas encontradas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: _listaCasas.length,
              itemBuilder: (context, index) {
                final casa = _listaCasas[index];
                return CardCasa(casa: casa);
              },
            ),
          ),
        ],
      ),
    );
  }
}
