-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-04-29 14:33:20.892

-- tables
-- Table: Jogo
CREATE TABLE Jogo (
    nome varchar(100)  NOT NULL,
    data date  NOT NULL,
    resultado varchar(10) ,
    time_id int  NOT NULL,
    time_2_id int  NOT NULL,
    CONSTRAINT Jogo_pk PRIMARY KEY (nome)
);

-- Table: escalação
CREATE TABLE escalação (
    posição varchar(20)  NOT NULL,
    jogador_cpf char(11)  NOT NULL,
    Jogo_nome varchar(100)  NOT NULL,
    CONSTRAINT escalação_pk PRIMARY KEY (Jogo_nome,jogador_cpf)
);

-- Table: jogador
CREATE TABLE jogador (
    nome varchar(30)  NOT NULL,
    idade int  NOT NULL,
    altura int  NOT NULL,
    cpf char(11)  NOT NULL,
    posição varchar(20) ,
    time_id int ,
    CONSTRAINT jogador_pk PRIMARY KEY (cpf)
);

-- Table: time
CREATE TABLE time (
    nome varchar(30)  NOT NULL,
    id int  NOT NULL,
    pais varchar(20)  NOT NULL,
    cidade varchar(20)  NOT NULL,
    CONSTRAINT time_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Jogo_time (table: Jogo)
ALTER TABLE Jogo ADD CONSTRAINT Jogo_time
    FOREIGN KEY (time_id)
    REFERENCES time (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Jogo_time (table: Jogo)
ALTER TABLE Jogo ADD CONSTRAINT Jogo_time
    FOREIGN KEY (time_2_id)
    REFERENCES time (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: escalação_Jogo (table: escalação)
ALTER TABLE escalação ADD CONSTRAINT escalação_Jogo
    FOREIGN KEY (Jogo_nome)
    REFERENCES Jogo (nome)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: escalação_jogador (table: escalação)
ALTER TABLE escalação ADD CONSTRAINT escalação_jogador
    FOREIGN KEY (jogador_cpf)
    REFERENCES jogador (cpf)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: jogador_time (table: jogador)
ALTER TABLE jogador ADD CONSTRAINT jogador_time
    FOREIGN KEY (time_id)
    REFERENCES time (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

