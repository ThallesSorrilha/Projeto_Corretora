import 'package:projeto_corretora/dto/dto.dart';

class PessoaDTO extends DTO{
  final String sobrenome;
  final String telefone;
  final String email;
  final int cidadeId;

  PessoaDTO({
    super.id,
    required super.nome,
    required this.sobrenome,
    required this.telefone,
    required this.email,
    required this.cidadeId,
  });
}