class CasaDTO {
  final int? id;
  final String endereco;
  final double preco;
  final int cidadeId;
  final bool ativa;

  CasaDTO({
    this.id,
    required this.endereco,
    required this.preco,
    required this.cidadeId,
    this.ativa = true,
  });
}