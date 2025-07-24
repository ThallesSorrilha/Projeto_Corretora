const criarTabelas = [
  '''
  CREATE TABLE estado (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    sigla TEXT NOT NULL
  )
  ''',
  '''
  CREATE TABLE cidade (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    estadoId INTEGER NOT NULL,
    FOREIGN KEY (estadoId) REFERENCES estado(id)
  )
  ''',
  '''
  CREATE TABLE pessoa (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    sobrenome TEXT NOT NULL,
    telefone TEXT NOT NULL,
    email TEXT NOT NULL,
    cidadeId INTEGER NOT NULL,
    FOREIGN KEY (cidadeId) REFERENCES cidade(id)
  )
  ''',
  '''
  CREATE TABLE casa (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    endereco TEXT NOT NULL,
    preco REAL NOT NULL,
    cidadeId INTEGER NOT NULL,
    ativa INTEGER NOT NULL DEFAULT 1,
    descricao TEXT,
    FOREIGN KEY (cidadeId) REFERENCES cidade(id)
  )
  '''
];