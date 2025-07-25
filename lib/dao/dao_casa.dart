import 'package:projeto_corretora/dto/dto_casa.dart';
import 'package:projeto_corretora/conexao.dart';

class CasaDao {
  final String sqlInsert = '''
    INSERT INTO casa (
      nome, cidadeId, bairro, logradouro, numero, tipo, area, preco, ativa, descricao, usuarios
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  ''';
  final String sqlUpdate = '''
    UPDATE casa SET
      nome = ?, cidadeId = ?, bairro = ?, logradouro = ?, numero = ?, tipo = ?, area = ?, preco = ?, ativa = ?, descricao = ?, usuarios = ?
    WHERE id = ?
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
        dto.cidadeId,
        dto.bairro,
        dto.logradouro,
        dto.numero,
        dto.tipo,
        dto.area,
        dto.preco,
        dto.ativa ? 1 : 0,
        dto.descricao,
        dto.usuarios,
      ]);
    } else {
      return await db.rawUpdate(sqlUpdate, [
        dto.nome,
        dto.cidadeId,
        dto.bairro,
        dto.logradouro,
        dto.numero,
        dto.tipo,
        dto.area,
        dto.preco,
        dto.ativa ? 1 : 0,
        dto.descricao,
        dto.usuarios,
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
      cidadeId: map['cidadeId'] as int,
      bairro: map['bairro'] as String,
      logradouro: map['logradouro'] as String,
      numero: map['numero'] as int,
      tipo: map['tipo'] as String,
      area:
          map['area'] is int
              ? (map['area'] as int).toDouble()
              : map['area'] as double,
      preco:
          map['preco'] is int
              ? (map['preco'] as int).toDouble()
              : map['preco'] as double,
      ativa: (map['ativa'] == 1),
      descricao: map['descricao'] as String?,
      usuarios: map['usuarios'] as int?,
    );
  }

  Map<String, dynamic> toMap(CasaDTO dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
      'cidadeId': dto.cidadeId,
      'bairro': dto.bairro,
      'logradouro': dto.logradouro,
      'numero': dto.numero,
      'tipo': dto.tipo,
      'area': dto.area,
      'preco': dto.preco,
      'ativa': dto.ativa ? 1 : 0,
      'descricao': dto.descricao,
      'usuarios': dto.usuarios,
    };
  }
}
