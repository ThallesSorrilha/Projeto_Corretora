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
    preco REAL NOT NULL,
    cidadeId INTEGER NOT NULL,
    bairro TEXT NOT NULL,
    logradouro TEXT NOT NULL,
    numero INTEGER NOT NULL,
    tipo TEXT NOT NULL,
    area DECIMAL NOT NULL,
    ativa INTEGER NOT NULL DEFAULT 1,
    descricao TEXT,
    FOREIGN KEY (cidadeId) REFERENCES cidade(id)
  )
  ''',
  '''
  CREATE TABLE casa_pessoa (
    casaId INTEGER NOT NULL,
    pessoaId INTEGER NOT NULL,
    FOREIGN KEY (casaId) REFERENCES casa(id) ON DELETE CASCADE,
    FOREIGN KEY (pessoaId) REFERENCES pessoa(id) ON DELETE CASCADE,
    PRIMARY KEY (casaId, pessoaId)
  )
  ''',
];

const criarTabelasWeb = [
  '''
  CREATE TABLE IF NOT EXISTS estado (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    sigla TEXT NOT NULL
  )
  ''',
  '''
  CREATE TABLE IF NOT EXISTS cidade (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    estadoId INTEGER NOT NULL,
    FOREIGN KEY (estadoId) REFERENCES estado(id)
  )
  ''',
  '''
  CREATE TABLE IF NOT EXISTS pessoa (
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
  CREATE TABLE IF NOT EXISTS casa (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    preco REAL NOT NULL,
    cidadeId INTEGER NOT NULL,
    bairro TEXT NOT NULL,
    logradouro TEXT NOT NULL,
    numero INTEGER NOT NULL,
    tipo TEXT NOT NULL,
    area DECIMAL NOT NULL,
    ativa INTEGER NOT NULL DEFAULT 1,
    descricao TEXT,
    FOREIGN KEY (cidadeId) REFERENCES cidade(id)
  )
  ''',
  '''
  CREATE TABLE IF NOT EXISTS casa_pessoa (
    casaId INTEGER NOT NULL,
    pessoaId INTEGER NOT NULL,
    FOREIGN KEY (casaId) REFERENCES casa(id) ON DELETE CASCADE,
    FOREIGN KEY (pessoaId) REFERENCES pessoa(id) ON DELETE CASCADE,
    PRIMARY KEY (casaId, pessoaId)
  )
  ''',
];
