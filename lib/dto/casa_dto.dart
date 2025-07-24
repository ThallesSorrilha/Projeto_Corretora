import 'package:projeto_corretora/dto/dto.dart';

class CasaDTO extends DTO {
  final String endereco;
  final double preco;
  final int cidadeId;
  final bool ativa;
  final bool? descricao;

  CasaDTO({
    super.id,
    required super.nome,
    required this.endereco,
    required this.preco,
    required this.cidadeId,
    this.ativa = true,
    this.descricao
  });
}