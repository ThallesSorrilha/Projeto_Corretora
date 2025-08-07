class CasaPessoaDao {
  final String sqlInsert = '''
    INSERT INTO casa_pessoa (casaId, pessoaId) VALUES (?, ?)
  ''';
  final String sqlSelectAll = '''
    SELECT * FROM casa_pessoa
  ''';
  final String sqlSelectById = '''
    SELECT * FROM casa_pessoa WHERE id = ?
  ''';
  final String sqlDelete = '''
    DELETE FROM casa_pessoa WHERE casaId = ?
  ''';
}
