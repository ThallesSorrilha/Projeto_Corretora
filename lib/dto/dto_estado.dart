import 'package:projeto_corretora/dto/dto.dart';

class EstadoDTO extends DTO{
  final String sigla;

  EstadoDTO({
    super.id,
    required super.nome,
    required this.sigla,
  });
}