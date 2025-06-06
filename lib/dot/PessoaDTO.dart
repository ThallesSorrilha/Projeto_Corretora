class PessoaDTO {
  final int? id;
  final String nome;
  final String sobrenome;
  final String telefone;
  final String email;
  final int cidadeId;

  PessoaDTO({
    this.id,
    required this.nome,
    required this.sobrenome,
    required this.telefone,
    required this.email,
    required this.cidadeId,
  });
}