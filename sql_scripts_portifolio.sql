DROP DATABASE IF EXISTS faculdade;
CREATE DATABASE faculdade;
USE faculdade;

CREATE TABLE tbl_aluno (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome_aluno VARCHAR(100) NOT NULL,
    email_aluno VARCHAR(100),
    telefone_aluno VARCHAR(15),
    data_nascimento DATE,
    cpf VARCHAR(14),
    endereco VARCHAR(200)
);

CREATE TABLE tbl_professor (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome_professor VARCHAR(100) NOT NULL,
    email_professor VARCHAR(100),
    telefone_professor VARCHAR(15),
    titulacao VARCHAR(50)
);

CREATE TABLE tbl_curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nome_curso VARCHAR(100) NOT NULL,
    duracao INT
);


CREATE TABLE tbl_disciplina (
    id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    nome_disciplina VARCHAR(100) NOT NULL,
    carga_horaria INT,
    fk_id_curso INT NOT NULL,
    CONSTRAINT fk_disciplina_curso
        FOREIGN KEY (fk_id_curso)
        REFERENCES tbl_curso(id_curso)
);


CREATE TABLE tbl_turma (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    semestre VARCHAR(10) NOT NULL,
    fk_id_disciplina INT NOT NULL,
    fk_id_professor INT NOT NULL,
    CONSTRAINT fk_turma_disciplina
        FOREIGN KEY (fk_id_disciplina)
        REFERENCES tbl_disciplina(id_disciplina),
    CONSTRAINT fk_turma_professor
        FOREIGN KEY (fk_id_professor)
        REFERENCES tbl_professor(id_professor)
);

CREATE TABLE tbl_matricula (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_aluno INT NOT NULL,
    fk_id_turma INT NOT NULL,
    nota DECIMAL(5,2),
    frequencia DECIMAL(5,2),
    CONSTRAINT fk_matricula_aluno
        FOREIGN KEY (fk_id_aluno)
        REFERENCES tbl_aluno(id_aluno),
    CONSTRAINT fk_matricula_turma
        FOREIGN KEY (fk_id_turma)
        REFERENCES tbl_turma(id_turma)
);

CREATE TABLE tbl_metodo_pagamento (
    id_metodo_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    nome_metodo VARCHAR(50) NOT NULL,
    descricao VARCHAR(200)
);

CREATE TABLE tbl_pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_matricula INT NOT NULL,
    fk_id_metodo_pagamento INT NOT NULL,
    data_pagamento DATE NOT NULL,
    valor_pagamento DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDENTE',
    observacoes TEXT,
    CONSTRAINT fk_pagamento_matricula
        FOREIGN KEY (fk_id_matricula)
        REFERENCES tbl_matricula(id_matricula),
    CONSTRAINT fk_pagamento_metodo
        FOREIGN KEY (fk_id_metodo_pagamento)
        REFERENCES tbl_metodo_pagamento(id_metodo_pagamento)
);

-- ===========================================================
-- INSERÇÃO DE DADOS - EXEMPLO
-- ===========================================================


INSERT INTO tbl_aluno (nome_aluno, email_aluno, telefone_aluno, data_nascimento, cpf, endereco)
VALUES
  ('Alice da Silva',   'alice.silva@example.com', '(11) 91234-5678', '2000-05-10', '123.456.789-00', 'Rua das Flores, 123'),
  ('Bruno Pereira',    'bruno.p@example.com',     '(21) 95555-1234', '1998-09-22', '987.654.321-00', 'Av. Central, 456'),
  ('Carla Santos',     'carla.santos@example.com','(31) 90000-1111', '1997-03-15', NULL,            'Rua Verde, 789'),
  ('Daniel Souza',     'daniel.souza@example.com','(47) 98888-7777', '1999-12-01', '123.987.654-11', 'Praça das Árvores, 32');


INSERT INTO tbl_professor (nome_professor, email_professor, telefone_professor, titulacao)
VALUES
  ('Fernando Rocha',   'fernando.rocha@example.com', '(11) 98888-0000', 'Mestre'),
  ('Gabriela Azevedo', 'gabriela.azevedo@example.com','(21) 97777-1111', 'Doutora'),
  ('Hugo Martins',     'hugo.martins@example.com',    '(31) 96666-2222', 'Especialista');

INSERT INTO tbl_curso (nome_curso, duracao)
VALUES
  ('Engenharia de Software', 8),
  ('Administração',          8),
  ('Ciências Contábeis',     8);


INSERT INTO tbl_disciplina (nome_disciplina, carga_horaria, fk_id_curso)
VALUES
  ('Algoritmos',            60, 1),  -- Para Engenharia de Software
  ('Sistemas Operacionais', 80, 1),
  ('Matemática Financeira', 40, 3),  -- Para Ciências Contábeis
  ('Gestão de Projetos',    60, 1),
  ('Marketing',             50, 2),  -- Para Administração
  ('Contabilidade Geral',   70, 3);


INSERT INTO tbl_turma (semestre, fk_id_disciplina, fk_id_professor)
VALUES
  ('2025-1', 1, 1),  
  ('2025-1', 2, 2),  
  ('2025-2', 4, 3),  
  ('2025-1', 5, 2),  
  ('2025-2', 6, 1);  


INSERT INTO tbl_matricula (fk_id_aluno, fk_id_turma, nota, frequencia)
VALUES
  (1, 1,  8.5, 95.0), 
  (1, 2,  7.0, 88.0), 
  (2, 1,  6.5, 90.0), 
  (3, 2,  9.0, 98.0), 
  (2, 4,  7.8, 85.0), 
  (3, 4,  8.0, 92.0), 
  (4, 3,  8.2, 89.0), 
  (4, 5,  NULL, NULL);


INSERT INTO tbl_metodo_pagamento (nome_metodo, descricao)
VALUES
  ('Boleto Bancário', 'Emitido pelo banco XYZ'),
  ('Cartão de Crédito','Aceita bandeiras Visa e Mastercard'),
  ('PIX',             'Pagamento instantâneo via chave Pix');


INSERT INTO tbl_pagamento
(fk_id_matricula, fk_id_metodo_pagamento, data_pagamento, valor_pagamento, status, observacoes)
VALUES
  (1, 1, '2025-02-10',  800.00, 'PAGO',    'Pagamento da primeira mensalidade via Boleto'),
  (2, 2, '2025-02-11',  800.00, 'PENDENTE','Tentativa de pagamento por cartão; aguardando aprovação'),
  (3, 3, '2025-02-09',  800.00, 'PAGO',    'Pagamento via PIX com desconto de pontualidade'),
  (4, 1, '2025-03-05', 1200.00, 'PAGO',    'Pagamento 2/3 do semestre'),
  (5, 1, '2025-03-07',  750.00, 'PENDENTE','Boleto em aberto'),
  (8, 3, '2025-04-01', 1000.00, 'PAGO',    'Daniel - pagamento de turmas 3 e 5');

-- ===========================================================
-- CONSULTAS 
-- ===========================================================


SELECT * FROM tbl_aluno;


SELECT * FROM tbl_professor;


SELECT * FROM tbl_curso;


SELECT d.id_disciplina,
       d.nome_disciplina,
       d.carga_horaria,
       c.nome_curso AS curso_relacionado
  FROM tbl_disciplina d
  JOIN tbl_curso c
    ON d.fk_id_curso = c.id_curso;


SELECT t.id_turma,
       t.semestre,
       d.nome_disciplina,
       p.nome_professor
  FROM tbl_turma t
  JOIN tbl_disciplina d
    ON t.fk_id_disciplina = d.id_disciplina
  JOIN tbl_professor p
    ON t.fk_id_professor = p.id_professor;


SELECT m.id_matricula,
       a.nome_aluno,
       t.semestre,
       d.nome_disciplina,
       m.nota,
       m.frequencia
  FROM tbl_matricula m
  JOIN tbl_aluno a
    ON m.fk_id_aluno = a.id_aluno
  JOIN tbl_turma t
    ON m.fk_id_turma = t.id_turma
  JOIN tbl_disciplina d
    ON t.fk_id_disciplina = d.id_disciplina
 ORDER BY a.nome_aluno;


SELECT pg.id_pagamento,
       m.id_matricula,
       a.nome_aluno,
       mp.nome_metodo AS metodo_pagto,
       pg.data_pagamento,
       pg.valor_pagamento,
       pg.status
  FROM tbl_pagamento pg
  JOIN tbl_matricula m
    ON pg.fk_id_matricula = m.id_matricula
  JOIN tbl_aluno a
    ON m.fk_id_aluno = a.id_aluno
  JOIN tbl_metodo_pagamento mp
    ON pg.fk_id_metodo_pagamento = mp.id_metodo_pagamento
 ORDER BY pg.data_pagamento DESC;