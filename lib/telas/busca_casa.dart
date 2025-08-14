import 'package:flutter/material.dart';
import 'package:projeto_corretora/componentes/card_casa.dart';
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
      // Opcional: mostrar um SnackBar ou diálogo de erro
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Casas Disponíveis')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _listaCasas.isEmpty
              ? const Center(child: Text('Nenhuma casa encontrada.'))
              : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: _listaCasas.length,
                itemBuilder: (context, index) {
                  final casa = _listaCasas[index];
                  return CardCasa(casa: casa);
                },
              ),
    );
  }
}
