import 'package:flutter/material.dart';
import 'package:projeto_corretora/dto/dto_casa.dart';

class DetalhesCasa extends StatelessWidget {
  final CasaDTO casa;

  const DetalhesCasa({Key? key, required this.casa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(casa.nome),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nome: ${casa.nome}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('Área: ${casa.area} m²'),
              Text('Preço: R\$ ${casa.preco.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}