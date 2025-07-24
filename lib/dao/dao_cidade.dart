import 'package:projeto_corretora/dto/dto_cidade.dart';
import 'package:projeto_corretora/conexao.dart';

class DAOCidade {
  final String sqlInsert = '''
    INSERT INTO cidade (nome, estadoId) VALUES (?, ?)
  ''';
  final String sqlUpdate = '''
    UPDATE cidade SET nome = ?, estadoId = ? WHERE id = ?
  ''';
  final String sqlSelectAll = '''
    SELECT * FROM cidade
  ''';
  final String sqlSelectById = '''
    SELECT * FROM cidade WHERE id = ?
  ''';
  final String sqlDelete = '''
    DELETE FROM cidade WHERE id = ?
  ''';

  Future<int> salvar(CidadeDTO dto) async {
    final db = await Conexao.get();
    if (dto.id == null) {
      return await db.rawInsert(sqlInsert, [dto.nome, dto.estadoId]);
    } else {
      return await db.rawUpdate(sqlUpdate, [dto.nome, dto.estadoId, dto.id]);
    }
  }

  Future<List<CidadeDTO>> consultarTodos() async {
    final db = await Conexao.get();
    final result = await db.rawQuery(sqlSelectAll);
    return result.map((e) => fromMap(e)).toList();
  }

  Future<CidadeDTO?> consultarPorId(int id) async {
    final db = await Conexao.get();
    final result = await db.rawQuery(sqlSelectById, [id]);
    if (result.isEmpty) return null;
    return fromMap(result.first);
  }

  Future<int> excluir(int id) async {
    final db = await Conexao.get();
    return await db.rawDelete(sqlDelete, [id]);
  }

  CidadeDTO fromMap(Map<String, dynamic> map) {
    return CidadeDTO(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      estadoId: map['estadoId'] as int,
    );
  }

  Map<String, dynamic> toMap(CidadeDTO dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
      'estadoId': dto.estadoId,
    };
  }
}