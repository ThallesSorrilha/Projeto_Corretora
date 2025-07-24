import 'package:projeto_corretora/dto/dto.dart';

class CidadeDTO extends DTO{
  final int estadoId;

  CidadeDTO({
    super.id,
    required super.nome,
    required this.estadoId,
  });
}