import 'package:projeto_corretora/dto/dto.dart';

class CasaDTO extends DTO {
  final int cidadeId;
  final String bairro;
  final String logradouro;
  final int numero;
  final String tipo;
  final double area;
  final double preco;
  final bool ativa;
  final String? descricao;
  final int? usuarios;

  CasaDTO({
    super.id,
    required super.nome,
    required this.cidadeId,
    required this.bairro,
    required this.logradouro,
    required this.numero,
    required this.tipo,
    required this.area,
    required this.preco,
    required this.ativa,
    this.descricao,
    this.usuarios,
  });
}
