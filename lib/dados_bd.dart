const popularBancoDeDados = [
  // Inserir Estados
  '''
  INSERT INTO estado (nome, sigla) VALUES ('Paraná', 'PR');
  ''',
  '''
  INSERT INTO estado (nome, sigla) VALUES ('Santa Catarina', 'SC');
  ''',
  '''
  INSERT INTO estado (nome, sigla) VALUES ('São Paulo', 'SP');
  ''',

  // Inserir Cidades (assumindo que os IDs dos estados são 1, 2 e 3, respectivamente)
  '''
  INSERT INTO cidade (nome, estadoId) VALUES ('Maringá', 1);
  ''',
  '''
  INSERT INTO cidade (nome, estadoId) VALUES ('Florianópolis', 2);
  ''',
  '''
  INSERT INTO cidade (nome, estadoId) VALUES ('Campinas', 3);
  ''',

  // Inserir Pessoas (assumindo que os IDs das cidades são 1, 2 e 3, respectivamente)
  '''
  INSERT INTO pessoa (nome, sobrenome, telefone, email, cidadeId) VALUES ('João', 'Silva', '(44) 99123-4567', 'joao.silva@email.com', 1);
  ''',
  '''
  INSERT INTO pessoa (nome, sobrenome, telefone, email, cidadeId) VALUES ('Maria', 'Santos', '(48) 99876-5432', 'maria.santos@email.com', 2);
  ''',
  '''
  INSERT INTO pessoa (nome, sobrenome, telefone, email, cidadeId) VALUES ('Pedro', 'Gomes', '(11) 99345-6789', 'pedro.gomes@email.com', 3);
  ''',

  // Inserir Casas (assumindo que os IDs das cidades são 1, 2 e 3, respectivamente)
  '''
  INSERT INTO casa (nome, cidadeId, bairro, logradouro, numero, tipo, area, preco, ativa, descricao) VALUES ('Casa A', 1, 'Centro', 'Rua Principal', 123, 'Casa', 150.5, 250000.00, 1, 'Casa com 3 quartos e jardim.');
  ''',
  '''
  INSERT INTO casa (nome, cidadeId, bairro, logradouro, numero, tipo, area, preco, ativa, descricao) VALUES ('Apartamento B', 2, 'Coqueiros', 'Av. Beira Mar', 456, 'Apartamento', 85.0, 450000.00, 1, 'Apartamento de frente para o mar.');
  ''',
  '''
  INSERT INTO casa (nome, cidadeId, bairro, logradouro, numero, tipo, area, preco, ativa, descricao) VALUES ('Sobrado C', 3, 'Cambui', 'Rua das Flores', 789, 'Sobrado', 220.7, 780000.00, 0, 'Sobrado moderno com piscina.');
  ''',

  // Inserir Relacionamentos Casa-Pessoa (tabela casa_pessoa)
  // Assumindo IDs de casa e pessoa de 1 a 3, respectivamente
  // Relação 1: Casa A (ID 1) está relacionada a João (ID 1) e Pedro (ID 3)
  '''
  INSERT INTO casa_pessoa (casaId, pessoaId) VALUES (1, 1);
  ''',
  '''
  INSERT INTO casa_pessoa (casaId, pessoaId) VALUES (1, 3);
  ''',
  // Relação 2: Apartamento B (ID 2) está relacionado a Maria (ID 2)
  '''
  INSERT INTO casa_pessoa (casaId, pessoaId) VALUES (2, 2);
  ''',
  // Relação 3: Sobrado C (ID 3) não tem nenhum usuário relacionado
];
