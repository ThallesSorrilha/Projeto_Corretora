import 'package:flutter/material.dart';
import 'package:projeto_corretora/dto/dto_casa.dart';
import 'package:intl/intl.dart';

class DetalhesCasa extends StatelessWidget {
  final CasaDTO casa;

  const DetalhesCasa({Key? key, required this.casa}) : super(key: key);

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.lightGreen, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(casa.nome),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/casinha.jpg', fit: BoxFit.cover, height: 250),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    icon: Icons.label,
                    title: 'Nome',
                    value: casa.nome,
                  ),
                  _buildDetailRow(
                    icon: Icons.apartment,
                    title: 'Tipo',
                    value: casa.tipo,
                  ),
                  /*_buildDetailRow(
                    icon: Icons.location_city,
                    title: 'Cidade',
                    // A cidade precisa ser carregada do banco de dados ou passada no DTO
                    value: casa.cidadeNome, // Exemplo
                  ),*/
                  _buildDetailRow(
                    icon: Icons.location_on,
                    title: 'Bairro',
                    value: casa.bairro,
                  ),
                  _buildDetailRow(
                    icon: Icons.attach_money,
                    title: 'Preço',
                    value: currencyFormat.format(casa.preco),
                  ),
                  _buildDetailRow(
                    icon: Icons.square_foot,
                    title: 'Área',
                    value: '${casa.area} m²',
                  ),
                  _buildDetailRow(
                    icon: Icons.description,
                    title: 'Descrição',
                    value: casa.descricao ?? 'Nenhuma descrição fornecida.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
