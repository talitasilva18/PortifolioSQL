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

