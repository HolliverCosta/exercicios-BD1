--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.24
-- Dumped by pg_dump version 9.5.24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.vendas DROP CONSTRAINT medicamento;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT id_venda;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT id_farmacia;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT gerente_farmacia;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT funcao_venda;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT cpf_cliente;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT cliente_cpf;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT sede_unica;
ALTER TABLE ONLY public.medicamento DROP CONSTRAINT medicamento_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_bairro_key;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT entrega_pkey;
ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
DROP TABLE public.vendas;
DROP TABLE public.medicamento;
DROP TABLE public.funcionario;
DROP TABLE public.farmacia;
DROP TABLE public.entrega;
DROP TABLE public.cliente;
DROP TYPE public.estadotipo;
DROP EXTENSION btree_gist;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: estadotipo; Type: TYPE; Schema: public; Owner: holliverdoc
--

CREATE TYPE public.estadotipo AS ENUM (
    'PB',
    'RN',
    'CE',
    'PE',
    'AL',
    'SE',
    'BA',
    'MA',
    'PI'
);


ALTER TYPE public.estadotipo OWNER TO holliverdoc;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: holliverdoc
--

CREATE TABLE public.cliente (
    nome name NOT NULL,
    cpf character(11) NOT NULL,
    data_nascimento date NOT NULL,
    endereco_residencial text,
    endereco_trabalho text,
    endereco_outro text,
    CONSTRAINT check_algum_endereco CHECK (((endereco_residencial IS NOT NULL) OR (endereco_trabalho IS NOT NULL) OR (endereco_outro IS NOT NULL))),
    CONSTRAINT idade_valida CHECK (((data_nascimento + '18 years'::interval) < ('now'::text)::date))
);


ALTER TABLE public.cliente OWNER TO holliverdoc;

--
-- Name: entrega; Type: TABLE; Schema: public; Owner: holliverdoc
--

CREATE TABLE public.entrega (
    id integer NOT NULL,
    id_venda integer NOT NULL,
    cliente character(11),
    endereco text NOT NULL,
    CONSTRAINT endereco_valido CHECK (((endereco = 'residencial'::text) OR (endereco = 'trabalho'::text) OR (endereco = 'outro'::text)))
);


ALTER TABLE public.entrega OWNER TO holliverdoc;

--
-- Name: farmacia; Type: TABLE; Schema: public; Owner: holliverdoc
--

CREATE TABLE public.farmacia (
    id integer NOT NULL,
    tipo text NOT NULL,
    cpf_gerente character(11),
    gerente_funcao text,
    bairro text NOT NULL,
    cidade text NOT NULL,
    estado public.estadotipo NOT NULL,
    CONSTRAINT gerente_funcao_valido CHECK (((gerente_funcao = 'farmaceutico'::text) OR (gerente_funcao = 'administrador'::text))),
    CONSTRAINT tipo_valido CHECK (((tipo = 'sede'::text) OR (tipo = 'filial'::text)))
);


ALTER TABLE public.farmacia OWNER TO holliverdoc;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: holliverdoc
--

CREATE TABLE public.funcionario (
    nome name NOT NULL,
    cpf character(11) NOT NULL,
    funcao text NOT NULL,
    farmacia integer,
    CONSTRAINT funcao_valida CHECK (((funcao = 'farmaceutico'::text) OR (funcao = 'vendedor'::text) OR (funcao = 'entregador'::text) OR (funcao = 'caixa'::text) OR (funcao = 'administrador'::text)))
);


ALTER TABLE public.funcionario OWNER TO holliverdoc;

--
-- Name: medicamento; Type: TABLE; Schema: public; Owner: holliverdoc
--

CREATE TABLE public.medicamento (
    nome name,
    id integer NOT NULL,
    valor numeric,
    receita boolean NOT NULL,
    descricao text NOT NULL
);


ALTER TABLE public.medicamento OWNER TO holliverdoc;

--
-- Name: vendas; Type: TABLE; Schema: public; Owner: holliverdoc
--

CREATE TABLE public.vendas (
    id integer NOT NULL,
    valor numeric NOT NULL,
    id_farmacia integer NOT NULL,
    cpf_vendedor character(11),
    funcao_vendedor text NOT NULL,
    cpf_cliente character(11),
    id_medicamento integer,
    medicamento_receita boolean NOT NULL,
    CONSTRAINT funcao_valida CHECK ((funcao_vendedor = 'vendedor'::text)),
    CONSTRAINT medicamento_valido CHECK ((((medicamento_receita = true) AND (cpf_cliente IS NOT NULL)) OR (medicamento_receita = false)))
);


ALTER TABLE public.vendas OWNER TO holliverdoc;

--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: holliverdoc
--

INSERT INTO public.cliente (nome, cpf, data_nascimento, endereco_residencial, endereco_trabalho, endereco_outro) VALUES ('Holliver', '12345678930', '1999-08-30', 'avenida floriano', 'rua joaquin', 'rua peixoto');
INSERT INTO public.cliente (nome, cpf, data_nascimento, endereco_residencial, endereco_trabalho, endereco_outro) VALUES ('Luciana', '12345678931', '1990-08-30', 'avenida floriano', NULL, NULL);
INSERT INTO public.cliente (nome, cpf, data_nascimento, endereco_residencial, endereco_trabalho, endereco_outro) VALUES ('Ze felipe', '12345678932', '1980-08-30', NULL, 'rua joaquin', NULL);
INSERT INTO public.cliente (nome, cpf, data_nascimento, endereco_residencial, endereco_trabalho, endereco_outro) VALUES ('Luciano', '12345678933', '1994-08-30', NULL, NULL, 'rua peixoto');


--
-- Data for Name: entrega; Type: TABLE DATA; Schema: public; Owner: holliverdoc
--

INSERT INTO public.entrega (id, id_venda, cliente, endereco) VALUES (1, 1, '12345678931', 'residencial');


--
-- Data for Name: farmacia; Type: TABLE DATA; Schema: public; Owner: holliverdoc
--

INSERT INTO public.farmacia (id, tipo, cpf_gerente, gerente_funcao, bairro, cidade, estado) VALUES (1, 'sede', NULL, NULL, 'alto branco', 'campina grande', 'PB');
INSERT INTO public.farmacia (id, tipo, cpf_gerente, gerente_funcao, bairro, cidade, estado) VALUES (2, 'filial', '12345678911', 'farmaceutico', 'centro', 'campina grande', 'PB');
INSERT INTO public.farmacia (id, tipo, cpf_gerente, gerente_funcao, bairro, cidade, estado) VALUES (4, 'filial', NULL, NULL, 'bairro x', 'cidade x', 'PE');
INSERT INTO public.farmacia (id, tipo, cpf_gerente, gerente_funcao, bairro, cidade, estado) VALUES (5, 'filial', NULL, NULL, 'bairro c', 'cidade x', 'BA');
INSERT INTO public.farmacia (id, tipo, cpf_gerente, gerente_funcao, bairro, cidade, estado) VALUES (6, 'filial', NULL, NULL, 'bairro v', 'cidade x', 'AL');
INSERT INTO public.farmacia (id, tipo, cpf_gerente, gerente_funcao, bairro, cidade, estado) VALUES (7, 'filial', NULL, NULL, 'bairro b', 'cidade x', 'SE');
INSERT INTO public.farmacia (id, tipo, cpf_gerente, gerente_funcao, bairro, cidade, estado) VALUES (8, 'filial', NULL, NULL, 'bairro n', 'cidade x', 'MA');
INSERT INTO public.farmacia (id, tipo, cpf_gerente, gerente_funcao, bairro, cidade, estado) VALUES (9, 'filial', NULL, NULL, 'bairro m', 'cidade x', 'CE');
INSERT INTO public.farmacia (id, tipo, cpf_gerente, gerente_funcao, bairro, cidade, estado) VALUES (10, 'filial', NULL, NULL, 'bairro l', 'cidade x', 'RN');
INSERT INTO public.farmacia (id, tipo, cpf_gerente, gerente_funcao, bairro, cidade, estado) VALUES (11, 'filial', NULL, NULL, 'bairro k', 'cidade x', 'PI');


--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: holliverdoc
--

INSERT INTO public.funcionario (nome, cpf, funcao, farmacia) VALUES ('felipe', '12345678911', 'farmaceutico', 1);
INSERT INTO public.funcionario (nome, cpf, funcao, farmacia) VALUES ('mateus', '12345678913', 'entregador', 1);
INSERT INTO public.funcionario (nome, cpf, funcao, farmacia) VALUES ('caio', '12345678914', 'caixa', 1);
INSERT INTO public.funcionario (nome, cpf, funcao, farmacia) VALUES ('rebeca', '12345678915', 'administrador', 1);
INSERT INTO public.funcionario (nome, cpf, funcao, farmacia) VALUES ('gabriel', '12345678912', 'vendedor', 1);
INSERT INTO public.funcionario (nome, cpf, funcao, farmacia) VALUES ('joao', '12345678916', 'vendedor', NULL);


--
-- Data for Name: medicamento; Type: TABLE DATA; Schema: public; Owner: holliverdoc
--

INSERT INTO public.medicamento (nome, id, valor, receita, descricao) VALUES ('remedio x', 1, 30.00, false, 'fabricado em tal lugar com composto x');
INSERT INTO public.medicamento (nome, id, valor, receita, descricao) VALUES ('remedio y', 2, 70.00, true, 'fabricado em tal lugar com composto y');


--
-- Data for Name: vendas; Type: TABLE DATA; Schema: public; Owner: holliverdoc
--

INSERT INTO public.vendas (id, valor, id_farmacia, cpf_vendedor, funcao_vendedor, cpf_cliente, id_medicamento, medicamento_receita) VALUES (1, 30.00, 1, '12345678912', 'vendedor', '12345678931', 1, false);
INSERT INTO public.vendas (id, valor, id_farmacia, cpf_vendedor, funcao_vendedor, cpf_cliente, id_medicamento, medicamento_receita) VALUES (2, 70.00, 1, '12345678912', 'vendedor', '12345678932', 2, true);
INSERT INTO public.vendas (id, valor, id_farmacia, cpf_vendedor, funcao_vendedor, cpf_cliente, id_medicamento, medicamento_receita) VALUES (3, 30.00, 1, '12345678912', 'vendedor', NULL, 1, false);
INSERT INTO public.vendas (id, valor, id_farmacia, cpf_vendedor, funcao_vendedor, cpf_cliente, id_medicamento, medicamento_receita) VALUES (4, 30.00, 1, '12345678912', 'vendedor', NULL, 1, false);


--
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cpf);


--
-- Name: entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entrega_pkey PRIMARY KEY (id);


--
-- Name: farmacia_bairro_key; Type: CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_bairro_key UNIQUE (bairro);


--
-- Name: farmacia_pkey; Type: CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_pkey PRIMARY KEY (id);


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: medicamento_pkey; Type: CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.medicamento
    ADD CONSTRAINT medicamento_pkey PRIMARY KEY (id);


--
-- Name: sede_unica; Type: CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT sede_unica EXCLUDE USING gist (tipo WITH =) WHERE ((tipo = 'sede'::text));


--
-- Name: vendas_pkey; Type: CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_pkey PRIMARY KEY (id);


--
-- Name: cliente_cpf; Type: FK CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT cliente_cpf FOREIGN KEY (cliente) REFERENCES public.cliente(cpf);


--
-- Name: cpf_cliente; Type: FK CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT cpf_cliente FOREIGN KEY (cpf_cliente) REFERENCES public.cliente(cpf);


--
-- Name: funcao_venda; Type: FK CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT funcao_venda FOREIGN KEY (cpf_vendedor) REFERENCES public.funcionario(cpf) ON DELETE RESTRICT;


--
-- Name: gerente_farmacia; Type: FK CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT gerente_farmacia FOREIGN KEY (cpf_gerente) REFERENCES public.funcionario(cpf);


--
-- Name: id_farmacia; Type: FK CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT id_farmacia FOREIGN KEY (id_farmacia) REFERENCES public.farmacia(id);


--
-- Name: id_venda; Type: FK CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT id_venda FOREIGN KEY (id_venda) REFERENCES public.vendas(id);


--
-- Name: medicamento; Type: FK CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT medicamento FOREIGN KEY (id_medicamento) REFERENCES public.medicamento(id) ON DELETE RESTRICT;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
--COMANDOS ADICIONAIS
--

--Farmacia
CREATE TYPE ESTADOTIPO AS ENUM ('PB', 'RN', 'CE', 'PE', 'AL', 'SE', 'BA', 'MA', 'PI');

CREATE TABLE farmacia (id INTEGER NOT NULL, tipo TEXT NOT NULL, cpf_gerente CHAR(11),gerente_funcao TEXT, bairro TEXT NOT NULL, cidade TEXT NOT NULL, estado ESTADOTIPO NOT NULL, PRIMARY KEY(id));


ALTER TABLE farmacia ADD UNIQUE (bairro);

ALTER TABLE farmacia ADD CONSTRAINT tipo_valido CHECK (tipo = 'sede' OR tipo = 'filial');

ALTER TABLE farmacia ADD CONSTRAINT sede_unica EXCLUDE USING gist (tipo WITH= ) WHERE (tipo = 'sede');

ALTER TABLE farmacia ADD CONSTRAINT gerente_funcao_valido CHECK (gerente_funcao = 'farmaceutico' OR gerente_funcao = 'administrador');

--Funcionario

CREATE TABLE funcionario (nome NAME NOT NULL, cpf CHAR(11), funcao TEXT NOT NULL, farmacia INTEGER, PRIMARY KEY(cpf)); 

ALTER TABLE farmacia ADD CONSTRAINT gerente_farmacia FOREIGN KEY (cpf_gerente) REFERENCES funcionario (cpf);

ALTER TABLE funcionario ADD CONSTRAINT funcao_valida CHECK (funcao = 'farmaceutico' OR funcao = 'vendedor' OR funcao = 'entregador' OR funcao = 'caixa' OR funcao = 'administrador');


--Cliente

CREATE TABLE cliente (nome NAME NOT NULL, cpf CHAR(11), data_nascimento DATE NOT NULL, endereco_residencial TEXT, endereco_trabalho TEXT, endereco_outro TEXT, PRIMARY KEY(cpf));

ALTER TABLE cliente ADD CONSTRAINT idade_valida CHECK((data_nascimento + INTERVAL '18 year') < CURRENT_DATE);

ALTER TABLE cliente ADD CONSTRAINT check_algum_endereco CHECK(endereco_residencial IS NOT NULL OR endereco_trabalho IS NOT NULL OR endereco_outro IS NOT NULL);

--Vendas

CREATE TABLE vendas (id INTEGER, valor NUMERIC NOT NULL, id_farmacia INTEGER NOT NULL, cpf_vendedor CHAR(11), funcao_vendedor TEXT NOT NULL, cpf_cliente CHAR(11), id_medicamento INTEGER, medicamento_receita BOOLEAN NOT NULL, PRIMARY KEY(id));  

ALTER TABLE vendas ADD CONSTRAINT funcao_valida CHECK (funcao_vendedor = 'vendedor');

ALTER TABLE vendas ADD CONSTRAINT funcao_venda FOREIGN KEY (cpf_vendedor) REFERENCES funcionario (cpf) ON DELETE RESTRICT;

ALTER TABLE vendas ADD CONSTRAINT cpf_cliente FOREIGN KEY (cpf_cliente) REFERENCES cliente (cpf);

ALTER TABLE vendas ADD CONSTRAINT medicamento_valido CHECK(((medicamento_receita = '1') AND cpf_cliente IS NOT NULL) OR medicamento_receita = '0');

--Medicamentos

CREATE TABLE medicamento (nome NAME, id INTEGER NOT NULL, valor NUMERIC , receita BOOLEAN NOT NULL, descricao TEXT NOT NULL, PRIMARY KEY (id));

ALTER TABLE vendas ADD CONSTRAINT medicamento FOREIGN KEY (id_medicamento) REFERENCES medicamento (id) ON DELETE RESTRICT;

--Entrega

CREATE TABLE entrega (id INTEGER, id_venda INTEGER NOT NULL, cliente CHAR(11), PRIMARY KEY (id));

ALTER TABLE entrega ADD CONSTRAINT cliente_cpf FOREIGN KEY (cliente) REFERENCES cliente (cpf);

ALTER TABLE entrega ADD CONSTRAINT id_venda FOREIGN KEY (id_venda) REFERENCES vendas (id);

ALTER TABLE vendas ADD CONSTRAINT id_farmacia FOREIGN KEY (id_farmacia) REFERENCES farmacia (id);

--Requisitos

--Requisito 1

--Os comandos devem funcionar, adicionando farmacias

INSERT INTO farmacia VALUES(1, 'sede', null, null,'alto branco', 'campina grande','PB');
INSERT INTO farmacia VALUES(2, 'filial', null, null,'centro', 'campina grande','PB');

--Comando nao deve funcionar, pois so existe sede ou filial

INSERT INTO farmacia VALUES(3, 'principal', null, null,'maldivas', 'campina grande','PB'); 
--retorno: 
--ERROR:  new row for relation "farmacia" violates check constraint "tipo_valido"
--DETAIL:  Failing row contains (3, principal, null, null, maldivas, campina grande, PB).

--Requisito 2

--Os comandos devem funcionar, adicionando funcionarios

INSERT INTO funcionario VALUES ('felipe', 12345678911, 'farmaceutico', 1);

INSERT INTO funcionario VALUES ('gabriel', 12345678912, 'vendedor', 2);

INSERT INTO funcionario VALUES ('mateus', 12345678913, 'entregador', 1);

INSERT INTO funcionario VALUES ('caio', 12345678914, 'caixa', 1);

INSERT INTO funcionario VALUES ('rebeca', 12345678915, 'administrador', 1);

--O comando nao deve funcionar pois nao existe o tipo

INSERT INTO funcionario VALUES ('henrique', 12345678916, 'limpeza', 1);
--retorno:
--ERROR:  new row for relation "funcionario" violates check constraint "tipo_valido"
--DETAIL:  Failing row contains (henrique, 12345678916, limpeza, 1).

--Requisito 3 

--Deve funcionar, cada funcionario lotado em uma farmacia

UPDATE funcionario SET farmacia = 1 WHERE cpf = '12345678912';

SELECT * FROM funcionario ;

--Requisito 4

--Deve funcionar, adicionando um gerente a farmacia

UPDATE farmacia SET cpf_gerente = '12345678911', gerente_funcao = 'farmaceutico' WHERE id = 2;

--Nao deve funcionar pois nao é um funcionario

UPDATE farmacia SET cpf_gerente = '12345678920', gerente_funcao = 'farmaceutico' WHERE id = 2;
--retrno:
--ERROR:  insert or update on table "farmacia" violates foreign key constraint "gerente_farmacia"
--DETAIL:  Key (cpf_gerente)=(12345678920) is not present in table "funcionario".

--Requisito 5
-- deve funcionar, funcionario sem farmacia

INSERT INTO funcionario VALUES ('joao', 12345678916, 'vendedor', null);

--Requisito 6
-- Deve funcionar, adicionando cliente com 3 enderecos

INSERT INTO cliente VALUES ('Holliver', 12345678930, '1999-08-30', 'avenida floriano','rua joaquin', 'rua peixoto');

--Requisito 7

--Deve funcionar, adicionando clientes com apenas um endereco
INSERT INTO cliente VALUES ('Luciana', 12345678931, '1990-08-30', 'avenida floriano', null, null);

INSERT INTO cliente VALUES ('Ze felipe', 12345678932, '1980-08-30', null, 'rua joaquin', null);

INSERT INTO cliente VALUES ('Luciano', 12345678933, '1994-08-30', null, null, 'rua peixoto');

--Nao deve funcionar, sem endereco

INSERT INTO cliente VALUES ('Lucas', 12345678934, '1997-08-30', null, null, null);
--retonro:
--ERROR:  new row for relation "cliente" violates check constraint "check_algum_endereco"
--DETAIL:  Failing row contains (Lucas, 12345678934, 1997-08-30, null, null, null).

--Requisito 8 

--Deve funcionar, com venda exclusiva e sem venda exclusiva

INSERT INTO medicamento VALUES ('remedio x', 1, 30.00,false, 'fabricado em tal lugar com composto x');

INSERT INTO medicamento VALUES ('remedio y', 2, 70.00, true, 'fabricado em tal lugar com composto y');

--Requisito 9 

--adicionando vendas

INSERT INTO vendas VALUES (1, 30.00, 1, 12345678912, 'vendedor', '12345678931', 1, false);

INSERT INTO vendas VALUES (2, 70.00, 1, 12345678912, 'vendedor', '12345678932', 2, true);

INSERT INTO vendas VALUES (3, 30.00, 1, 12345678912, 'vendedor', null, 1, false);

--Adionando coluna endereco e a checagem 

ALTER TABLE entrega ADD COLUMN enderco TEXT NOT NULL;

ALTER TABLE entrega RENAME COLUMN enderco TO endereco;

ALTER TABLE entrega ADD CONSTRAINT endereco_valido CHECK (endereco='residencial' OR endereco='trabalho' OR endereco='outro');

--Deve funcionar, criando uma entrega com endereco valido

INSERT INTO entrega VALUES('1', '1', '12345678931','residencial');

--Nao deve funcionar cliente nao cadastrado

INSERT INTO entrega VALUES('2', '1', '12345678999','residencial');
--retorno:
--ERROR:  insert or update on table "entrega" violates foreign key constraint "cliente_cpf"
--DETAIL:  Key (cliente)=(12345678999) is not present in table "cliente".

--Requisito 10

--Deve funcionar, venda para clientes nao cadastrados

INSERT INTO vendas VALUES (4, 30.00, 1, 12345678912, 'vendedor', null, 1, false);

--Requisito 11

--Nao deve funcionar

DELETE FROM funcionario WHERE cpf = '12345678912';
--retorno:
--ERROR:  update or delete on table "funcionario" violates foreign key constraint "funcao_venda" on table "vendas"
--DETAIL:  Key (cpf)=(12345678912) is still referenced from table "vendas".

--Requisito 12

--Nao deve funcionar

DELETE FROM medicamento WHERE id = '1';
--retorno:
--ERROR:  update or delete on table "medicamento" violates foreign key constraint "medicamento" on table "vendas"
--DETAIL:  Key (id)=(1) is still referenced from table "vendas".

--Requisito 13

--Nao deve funcionar, cliente menor de 18

INSERT INTO cliente VALUES ('Leticia', 12345678935, '2010-08-30', null, null, 'rua peixoto');
--retorno:
--ERROR:  new row for relation "cliente" violates check constraint "idade_valida"
--DETAIL:  Failing row contains (Leticia, 12345678935, 2010-08-30, null, null, rua peixoto).

--Requisito 14

--Nao deve funcionar, so pode uma farmacia por bairro

INSERT INTO farmacia VALUES(3, 'filial', null, null,'alto branco', 'campina grande','PB');
--retorno:
--ERROR:  duplicate key value violates unique constraint "farmacia_bairro_key"
--DETAIL:  Key (bairro)=(alto branco) already exists.

--Requisito 15

--Nao deve funcionar, so existe uma sede de farmacia

INSERT INTO farmacia VALUES(4, 'sede', null, null,'mirante', 'campina grande','PB');
--retorno:
--ERROR:  conflicting key value violates exclusion constraint "sede_unica"
--DETAIL:  Key (tipo)=(sede) conflicts with existing key (tipo)=(sede).

--Requisito 16

--Nao deve funcionar, gerente so pode ser adm ou farmaceutico

UPDATE farmacia SET cpf_gerente = '12345678912', funcao_gerente = 'vendedor' WHERE id = 2;
--retorno:
--ERROR:  column "funcao_gerente" of relation "farmacia" does not exist
--LINE 1: UPDATE farmacia SET cpf_gerente = '12345678912', funcao_gere...

UPDATE farmacia SET cpf_gerente = '12345678913', funcao_gerente = 'entregador' WHERE id = 1;
--retorno:
--ERROR:  column "funcao_gerente" of relation "farmacia" does not exist
--LINE 1: UPDATE farmacia SET cpf_gerente = '12345678913', funcao_gere...

UPDATE farmacia SET cpf_gerente = '12345678914', funcao_gerente = 'caixa' WHERE id = 2;
--retorno:
--ERROR:  column "funcao_gerente" of relation "farmacia" does not exist
--LINE 1: UPDATE farmacia SET cpf_gerente = '12345678914', funcao_gere...

--Requisito 17

--Nao deve funcionar, vender medicamento  com receita sem cliente cadastrado 

INSERT INTO vendas VALUES (5, 70.00, 1, 12345678912, 'vendedor', '12345678999', 2, true);
--retrono:
--ERROR:  insert or update on table "vendas" violates foreign key constraint "cpf_cliente"
--DETAIL:  Key (cpf_cliente)=(12345678999) is not present in table "cliente".

--Requisito 18

--Nao deve funcionar, venda so pode ser feira por um vendedor

INSERT INTO vendas VALUES (5, 70.00, 2, 12345678911, 'farmaceutico', '12345678931', 2, true);
--retorno:
--ERROR:  new row for relation "vendas" violates check constraint "funcao_valida"
--DETAIL:  Failing row contains (5, 70.00, 2, 12345678911, farmaceutico, 12345678931, 2, t).


INSERT INTO vendas VALUES (6, 70.00, 2, 12345678913, 'entregador', '12345678931', 2, true);
--retorno:
--ERROR:  new row for relation "vendas" violates check constraint "funcao_valida"
--DETAIL:  Failing row contains (6, 70.00, 2, 12345678913, entregador, 12345678931, 2, t).

INSERT INTO vendas VALUES (7, 70.00, 2, 12345678914, 'caixa', '12345678931', 2, true);
--retorno:
--ERROR:  new row for relation "vendas" violates check constraint "funcao_valida"
--DETAIL:  Failing row contains (7, 70.00, 2, 12345678914, caixa, 12345678931, 2, t).

INSERT INTO vendas VALUES (8, 70.00, 2, 12345678915, 'administrador', '12345678931', 2, true);
--retorno:
--ERROR:  new row for relation "vendas" violates check constraint "funcao_valida"
--DETAIL:  Failing row contains (8, 70.00, 2, 12345678915, administrador, 12345678931, 2, t).

--Requisito 19

--Deve funcionar, todos os estados do nordeste 
INSERT INTO farmacia VALUES(4, 'filial', null, null,'bairro x', 'cidade x','PE');

INSERT INTO farmacia VALUES(5, 'filial', null, null,'bairro c', 'cidade x','BA');

INSERT INTO farmacia VALUES(6, 'filial', null, null,'bairro v', 'cidade x','AL');

INSERT INTO farmacia VALUES(7, 'filial', null, null,'bairro b', 'cidade x','SE');

INSERT INTO farmacia VALUES(8, 'filial', null, null,'bairro n', 'cidade x','MA');

INSERT INTO farmacia VALUES(9, 'filial', null, null,'bairro m', 'cidade x','CE');

INSERT INTO farmacia VALUES(10, 'filial', null, null,'bairro l', 'cidade x','RN');

INSERT INTO farmacia VALUES(11, 'filial', null, null,'bairro k', 'cidade x','PI');

--Nao deve funcionar estados que nao sao do nordeste 

INSERT INTO farmacia VALUES(12, 'filial', null, null,'bairro a', 'cidade x','ES');
--retorno:
--ERROR:  invalid input value for enum estadotipo: "ES"
--LINE 1: ...ALUES(12, 'filial', null, null,'bairro a', 'cidade x','ES');

INSERT INTO farmacia VALUES(13, 'filial', null, null,'bairro s', 'cidade x','MG');
--retorno:
--ERROR:  invalid input value for enum estadotipo: "MG"
--LINE 1: ...ALUES(13, 'filial', null, null,'bairro s', 'cidade x','MG');

