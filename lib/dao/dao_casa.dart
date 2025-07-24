import 'package:projeto_corretora/dto/dto_casa.dart';
import 'package:projeto_corretora/conexao.dart';

class DAOCasa {
  final String sqlInsert = '''
    INSERT INTO casa (nome, endereco, preco, cidadeId, ativa, descricao) VALUES (?, ?, ?, ?, ?, ?)
  ''';
  final String sqlUpdate = '''
    UPDATE casa SET nome = ?, endereco = ?, preco = ?, cidadeId = ?, ativa = ?, descricao = ? WHERE id = ?
  ''';
  final String sqlSelectAll = '''
    SELECT * FROM casa
  ''';
  final String sqlSelectById = '''
    SELECT * FROM casa WHERE id = ?
  ''';
  final String sqlDelete = '''
    DELETE FROM casa WHERE id = ?
  ''';

  Future<int> salvar(CasaDTO dto) async {
    final db = await Conexao.get();
    if (dto.id == null) {
      return await db.rawInsert(sqlInsert, [
        dto.nome,
        dto.endereco,
        dto.preco,
        dto.cidadeId,
        dto.ativa ? 1 : 0,
        dto.descricao,
      ]);
    } else {
      return await db.rawUpdate(sqlUpdate, [
        dto.nome,
        dto.endereco,
        dto.preco,
        dto.cidadeId,
        dto.ativa ? 1 : 0,
        dto.descricao,
        dto.id,
      ]);
    }
  }

  Future<List<CasaDTO>> consultarTodos() async {
    final db = await Conexao.get();
    final result = await db.rawQuery(sqlSelectAll);
    return result.map((e) => fromMap(e)).toList();
  }

  Future<CasaDTO?> consultarPorId(int id) async {
    final db = await Conexao.get();
    final result = await db.rawQuery(sqlSelectById, [id]);
    if (result.isEmpty) return null;
    return fromMap(result.first);
  }

  Future<int> excluir(int id) async {
    final db = await Conexao.get();
    return await db.rawDelete(sqlDelete, [id]);
  }

  CasaDTO fromMap(Map<String, dynamic> map) {
    return CasaDTO(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      endereco: map['endereco'] as String,
      preco:
          map['preco'] is int
              ? (map['preco'] as int).toDouble()
              : map['preco'] as double,
      cidadeId: map['cidadeId'] as int,
      ativa: (map['ativa'] == 1),
      descricao: map['descricao'] as String?,
    );
  }

  Map<String, dynamic> toMap(CasaDTO dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
      'endereco': dto.endereco,
      'preco': dto.preco,
      'cidadeId': dto.cidadeId,
      'ativa': dto.ativa ? 1 : 0,
      'descricao': dto.descricao,
    };
  }
}
