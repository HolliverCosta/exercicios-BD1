--Questão 1 (Definindo os atributos de cada tabela)
AUTOMOVEL - (marca, modelo, ano, numero de serie, cor,placa)
SEGURADO - (nome)
PERITO - (nome do perito)
OFICINA - (nome da oficina)
SEGURO - (tipo de seguro, validade)
SINISTRO - (informação de perda total ou parcial)
PERICIA - (analise do danos do carro)
REPARO - (reparo)
--Questão 2 (Criando a tabelas)

CREATE TABLE automovel(marca TEXT,modelo TEXT, ano INTEGER, num_serie INTEGER, cor TEXT, placa CHAR(7));

CREATE TABLE segurado(nome NAME, cpf NUMERIC);

CREATE TABLE perito(nome_perito NAME, cpf NUMERIC);

CREATE TABLE oficina(nome_oficina NAME);

CREATE TABLE seguro (tipo_seguro TEXT, validade DATE);

CREATE TABLE sinistro(informações TEXT);

CREATE TABLE pericia(analise TEXT);

CREATE TABLE reparo(reparo BOOLEAN);

--Questão 3(Definindo as chaves primarias)

ALTER TABLE automovel ADD PRIMARY KEY(num_serie);

ALTER TABLE segurado ADD PRIMARY KEY(cpf);

ALTER TABLE perito ADD PRIMARY KEY(cpf);

ALTER TABLE oficina ADD PRIMARY KEY(nome_oficina);

ALTER TABLE seguro ADD COLUMN id NUMERIC;

ALTER TABLE seguro ADD PRIMARY KEY(id);

ALTER TABLE sinistro ADD COLUMN id NUMERIC;

ALTER TABLE sinistro ADD PRIMARY KEY(id);

ALTER TABLE pericia ADD COLUMN id NUMERIC;

ALTER TABLE pericia ADD PRIMARY KEY(id);

ALTER TABLE reparo ADD COLUMN id NUMERIC;

ALTER TABLE reparo ADD PRIMARY KEY(id);

--Questão 4(Definindo as chaves estrangeiras)

ALTER TABLE automovel ADD COLUMN cpf_segurado NUMERIC;

ALTER TABLE automovel ADD CONSTRAINT cpf_segurado FOREIGN KEY (cpf_segurado) REFERENCES segurado (cpf);

ALTER TABLE oficina ADD COLUMN endereco TEXT;

ALTER TABLE segurado ADD COLUMN idSeguro NUMERIC;

ALTER TABLE segurado ADD CONSTRAINT idSeguro FOREIGN KEY (idSeguro) REFERENCES seguro (id);

ALTER TABLE automovel ADD COLUMN id NUMERIC;

ALTER TABLE oficina ADD COLUMN id_automovel NUMERIC;

ALTER TABLE oficina ADD CONSTRAINT id_automove FOREIGN KEY (id_automovel) REFERENCES automovel (id);

ALTER TABLE pericia ADD COLUMN cpf_perito NUMERIC;

ALTER TABLE pericia ADD CONSTRAINT cpf_perito FOREIGN KEY (cpf_perito) REFERENCES perito (cpf);

ALTER TABLE seguro ADD COLUMN id_sinistro NUMERIC;

ALTER TABLE seguro ADD CONSTRAINT id_sinistro FOREIGN KEY (id_sinistro) REFERENCES sinistro (id);

ALTER TABLE segurado ADD COLUMN num_serie_automovel INTEGER;

ALTER TABLE segurado ADD CONSTRAINT num_serie_automovel FOREIGN KEY (num_serie_automovel) REFERENCES automovel (num_serie);

ALTER TABLE sinistro ADD COLUMN id_pericia INTEGER;

ALTER TABLE sinistro ADD CONSTRAINT id_pericia FOREIGN KEY (id_pericia) REFERENCES pericia (id);

ALTER TABLE pericia ADD COLUMN id_reparo INTEGER;

ALTER TABLE pericia ADD CONSTRAINT id_reparo FOREIGN KEY (id_reparo) REFERENCES reparo (id);

ALTER TABLE reparo ADD COLUMN nome_oficina NAME;

ALTER TABLE reparo ADD CONSTRAINT nome_oficina FOREIGN KEY (nome_oficina) REFERENCES oficina (nome_oficina);

ALTER TABLE oficina ADD COLUMN num_serie_automovel INTEGER;

ALTER TABLE oficina ADD CONSTRAINT num_serie_automovel FOREIGN KEY (num_serie_automovel) REFERENCES automovel (num_serie);

-- Questão 6 (apagando todas as tabelas)
DROP TABLE automovel CASCADE;

DROP TABLE oficina CASCADE;

DROP TABLE perito CASCADE;

DROP TABLE pericia CASCADE;

DROP TABLE reparo CASCADE;

DROP TABLE segurado CASCADE;

DROP TABLE seguro CASCADE;

DROP TABLE sinistro CASCADE;

--Questão 7 e 8(criando as tabelas com todas as constraints)

CREATE TABLE automovel(marca TEXT NOT NULL,modelo TEXT NOT NULL, ano INTEGER NOT NULL, num_serie CHAR(17), cor TEXT, placa CHAR(7), cpf_segurado NUMERIC(11), id NUMERIC, PRIMARY KEY(id));

CREATE TABLE segurado(nome NAME NOT NULL, cpf NUMERIC, id_Seguro NUMERIC, id_automovel INTEGER, PRIMARY KEY(cpf));

ALTER TABLE segurado ADD CONSTRAINT id_automovel FOREIGN KEY (id_automovel) REFERENCES automovel (id);

ALTER TABLE automovel ADD CONSTRAINT cpf_segurado FOREIGN KEY (cpf_segurado) REFERENCES segurado (cpf);

CREATE TABLE seguro (tipo_seguro TEXT NOT NULL, validade DATE NOT NULL,id NUMERIC,id_sinistro NUMERIC, PRIMARY KEY(id));

ALTER TABLE segurado ADD CONSTRAINT id_Seguro FOREIGN KEY (id_Seguro) REFERENCES seguro (id);

CREATE TABLE sinistro(informações TEXT, id NUMERIC, id_pericia INTEGER, PRIMARY KEY(id));

ALTER TABLE seguro ADD CONSTRAINT id_sinistro FOREIGN KEY (id_sinistro) REFERENCES sinistro (id);

CREATE TABLE pericia(analise TEXT, id NUMERIC, cpf_perito NUMERIC, id_reparo INTEGER, PRIMARY KEY(id));

ALTER TABLE sinistro ADD CONSTRAINT id_pericia FOREIGN KEY (id_pericia) REFERENCES pericia (id);

CREATE TABLE perito(nome_perito NAME, cpf NUMERIC, PRIMARY KEY(cpf));

ALTER TABLE pericia ADD CONSTRAINT cpf_perito FOREIGN KEY (cpf_perito) REFERENCES perito (cpf);

CREATE TABLE reparo(reparo BOOLEAN NOT NULL, id NUMERIC, nome_oficina NAME, PRIMARY KEY(id));

ALTER TABLE pericia ADD CONSTRAINT id_reparo FOREIGN KEY (id_reparo) REFERENCES reparo (id);

CREATE TABLE oficina(nome_oficina NAME, endereco TEXT, id_automovel INTEGER, PRIMARY KEY(nome_oficina));

ALTER TABLE oficina ADD CONSTRAINT id_automovel FOREIGN KEY (id_automovel) REFERENCES automovel (id);

ALTER TABLE reparo ADD CONSTRAINT nome_oficina FOREIGN KEY (nome_oficina) REFERENCES oficina (nome_oficina);

--Questao 9 (removendo todas as tabelas)

DROP TABLE automovel CASCADE;

DROP TABLE oficina CASCADE;

DROP TABLE perito CASCADE;

DROP TABLE pericia CASCADE;

DROP TABLE reparo CASCADE;

DROP TABLE segurado CASCADE;

DROP TABLE seguro CASCADE;

DROP TABLE sinistro CASCADE;
