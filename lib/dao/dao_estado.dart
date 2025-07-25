import 'package:projeto_corretora/dto/dto_estado.dart';
import 'package:projeto_corretora/conexao.dart';

class EstadoDAO {
  final String sqlInsert = '''
    INSERT INTO estado (nome, sigla) VALUES (?, ?)
  ''';
  final String sqlUpdate = '''
    UPDATE estado SET nome = ?, sigla = ? WHERE id = ?
  ''';
  final String sqlSelectAll = '''
    SELECT * FROM estado
  ''';
  final String sqlSelectById = '''
    SELECT * FROM estado WHERE id = ?
  ''';
  final String sqlDelete = '''
    DELETE FROM estado WHERE id = ?
  ''';

  Future<int> salvar(EstadoDTO dto) async {
    final db = await Conexao.get();
    if (dto.id == null) {
      return await db.rawInsert(sqlInsert, [dto.nome, dto.sigla]);
    } else {
      return await db.rawUpdate(sqlUpdate, [dto.nome, dto.sigla, dto.id]);
    }
  }

  Future<List<EstadoDTO>> consultarTodos() async {
    final db = await Conexao.get();
    final result = await db.rawQuery(sqlSelectAll);
    return result.map((e) => fromMap(e)).toList();
  }

  Future<EstadoDTO?> consultarPorId(int id) async {
    final db = await Conexao.get();
    final result = await db.rawQuery(sqlSelectById, [id]);
    if (result.isEmpty) return null;
    return fromMap(result.first);
  }

  Future<int> excluir(int id) async {
    final db = await Conexao.get();
    return await db.rawDelete(sqlDelete, [id]);
  }

  EstadoDTO fromMap(Map<String, dynamic> map) {
    return EstadoDTO(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      sigla: map['sigla'] as String,
    );
  }

  Map<String, dynamic> toMap(EstadoDTO dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
      'sigla': dto.sigla,
    };
  }
}