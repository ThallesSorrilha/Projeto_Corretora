import 'package:projeto_corretora/dto/dto_pessoa.dart';
import 'package:projeto_corretora/conexao.dart';

class PessoaDAO {
  final String sqlInsert = '''
    INSERT INTO pessoa (nome, sobrenome, telefone, email, cidadeId) VALUES (?, ?, ?, ?, ?)
  ''';
  final String sqlUpdate = '''
    UPDATE pessoa SET nome = ?, sobrenome = ?, telefone = ?, email = ?, cidadeId = ? WHERE id = ?
  ''';
  final String sqlSelectAll = '''
    SELECT * FROM pessoa
  ''';
  final String sqlSelectById = '''
    SELECT * FROM pessoa WHERE id = ?
  ''';
  final String sqlDelete = '''
    DELETE FROM pessoa WHERE id = ?
  ''';

  Future<int> salvar(PessoaDTO dto) async {
    final db = await Conexao.get();
    if (dto.id == null) {
      return await db.rawInsert(sqlInsert, [dto.nome, dto.sobrenome, dto.telefone, dto.email, dto.cidadeId]);
    } else {
      return await db.rawUpdate(sqlUpdate, [dto.nome, dto.sobrenome, dto.telefone, dto.email, dto.cidadeId, dto.id]);
    }
  }

  Future<List<PessoaDTO>> consultarTodos() async {
    final db = await Conexao.get();
    final result = await db.rawQuery(sqlSelectAll);
    return result.map((e) => fromMap(e)).toList();
  }

  Future<PessoaDTO?> consultarPorId(int id) async {
    final db = await Conexao.get();
    final result = await db.rawQuery(sqlSelectById, [id]);
    if (result.isEmpty) return null;
    return fromMap(result.first);
  }

  Future<int> excluir(int id) async {
    final db = await Conexao.get();
    return await db.rawDelete(sqlDelete, [id]);
  }

  PessoaDTO fromMap(Map<String, dynamic> map) {
    return PessoaDTO(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      sobrenome: map['sobrenome'] as String,
      telefone: map['telefone'] as String,
      email: map['email'] as String,
      cidadeId: map['cidadeId'] as int,
    );
  }

  Map<String, dynamic> toMap(PessoaDTO dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
      'sobrenome': dto.sobrenome,
      'telefone': dto.telefone,
      'email': dto.email,
      'cidadeId': dto.cidadeId,
    };
  }
}