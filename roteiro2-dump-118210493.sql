CREATE TABLE tarefas (id INTEGER, descricao TEXT, cpf CHAR(11), prioridade INTEGER, status CHAR(1));
--Questao 1 

--As inserções abaixo devem ser executadas com sucesso
INSERT INTO tarefas VALUES(2147483646, 'limpar chao do corredor central', '98765432111',0,'F');

INSERT INTO tarefas VALUES(2147483647, 'limpar janelas da sala 203', '98765432122',1,'F');

INSERT INTO tarefas VALUES(null, null, null, null, null);

--As inserções nao deve ser executadas
INSERT INTO tarefas VALUES(2147483644, 'limpar chao do corredor superior', '987654323211', 0, 'F');

INSERT INTO tarefas VALUES(2147483644, 'limpar chao do corredor superior', '98765432321', 0, 'FF');
--Comandos 1

--Questao 2 

ALTER TABLE tarefas ALTER COLUMN id TYPE BIGINT;  

INSERT INTO tarefas VALUES(2147483648, 'limpar portas do terreo', '32323232955', 4, 'A');
--Comandos 2

--Questao 3
ALTER TABLE tarefas ALTER COLUMN prioridade TYPE SMALLINT;

INSERT INTO tarefas VALUES(2147483649, 'limpar portas da entrada principal', '32322525199', 32768, 'A');

INSERT INTO tarefas VALUES(2147483650, 'limpar portas da entrada principal', '32333233288', 32769, 'A');
--Comandos 3

INSERT INTO tarefas VALUES(2147483651, 'limpar portas do 1o andar', '32323232911', 32767, 'A');

INSERT INTO tarefas VALUES(2147483652, 'limpar portas do 2o andar', '32323232911', 32766, 'A');
--Comandos 4

--Questao 4
ALTER TABLE tarefas RENAME COLUMN cpf TO func_resp_cpf;

DELETE FROM tarefas WHERE id IS NULL;

ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;

ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;

ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;

ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;

ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;

--Questao 5


ALTER TABLE tarefas ADD UNIQUE (id);

--Inserção deve funcionar

INSERT INTO tarefas VALUES(2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'A');

--Inserção nao deve funcionar apos o insert anterior

INSERT INTO tarefas VALUES(2147483653, 'aparar a grama da area frontal', '32323232911', 3, 'A');
--Comandos 5

--Questao 6
UPDATE tarefas SET status = 'P' WHERE status = 'A';

SELECT * FROM tarefas;

UPDATE tarefas SET status = 'C' WHERE status = 'F';

SELECT * FROM tarefas;

ALTER TABLE tarefas ADD CONSTRAINT status_valido CHECK (status = 'P' OR status = 'E' OR status = 'C');

--Questao 7
UPDATE tarefas SET prioridade = 5 WHERE prioridade = 32767;

UPDATE tarefas SET prioridade = 5 WHERE prioridade = 32766;

ALTER TABLE tarefas ADD CONSTRAINT prioridade_valida CHECK (prioridade < 6 OR prioridade >= 0);

--Questao 8
CREATE TABLE funcionario (cpf CHAR(11), data_nasc DATE NOT NULL, nome TEXT NOT NULL, funcao TEXT NOT NULL, nivel CHAR(1), superior_cpf CHAR(11), PRIMARY KEY(cpf));

ALTER TABLE funcionario ADD CONSTRAINT nivel_valido CHECK (nivel = 'J' OR nivel = 'P' OR nivel = 'S');

ALTER TABLE funcionario ADD CONSTRAINT cpf_superior FOREIGN KEY (superior_cpf) REFERENCES funcionario(cpf);

ALTER TABLE funcionario ADD CONSTRAINT limpeza_check CHECK (funcao = 'LIMPEZA' AND superior_cpf IS NOT NULL OR funcao = 'SUP_LIMPEZA');

ALTER TABLE funcionario ALTER COLUMN nivel SET NOT NULL;

--devem funcionar

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA','S',null);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA','J',12345678911);

--nao deve funcionar

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-04-09', 'jose da Silva', 'LIMPEZA','J',null);
--Comandos 6

--Questao 9
--Passa com Sucesso
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1990-04-08', 'Maria da Silva', 'SUP_LIMPEZA','S',null);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678914', '1975-05-18', 'Holliver da Silva', 'LIMPEZA','J',12345678913);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678915', '1960-07-28', 'Joao da Silva', 'SUP_LIMPEZA','P',null);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678916', '1977-05-10', 'Maisa da Silva', 'LIMPEZA','J',12345678915);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678917', '1970-01-01', 'Helder da Silva', 'SUP_LIMPEZA','S',null);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678918', '1976-03-30', 'Brenda da Silva', 'LIMPEZA','J',12345678917);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678919', '1980-03-08', 'Rebeca da Silva', 'SUP_LIMPEZA','P',null);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678920', '1990-09-10', 'Herbet da Silva', 'LIMPEZA','J',12345678919);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678921', '1980-02-12', 'Luciana da Silva', 'SUP_LIMPEZA','S',null);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678922', '1990-11-02', 'Djalma da Silva', 'LIMPEZA','J',12345678921);

--Nao passa
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1990-04-08', 'Ze da Silva', 'SUP_LIMPEZA','S',null);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES (null, '1975-05-18', 'Oliver da Silva', 'LIMPEZA','J',12345678913);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678915', null, 'Joao da Silva', 'SUP_LIMPEZA','P',null);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678916', '1977-05-10', null, 'LIMPEZA','J',12345678915);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678917', '1970-01-01', 'Helder da Silva', null,'S',null);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678918', '1976-03-30', 'Brenda da Silva', 'LIMPEZA',null,12345678917);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678923', '1980-03-08', 'Felipe da Silva', 'SUP_LIMPEZA','I',null);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678924', '1990-09-10', 'Elder da Silva', 'SUGEIRA','J',12345678919);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('1234567892123', '1980-02-12', 'Tarciso da Silva', 'SUP_LIMPEZA','S',null);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES (null, null, null, null,null,null);

--Questao 10
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232955', '1976-03-30', 'Hugo da Silva', 'LIMPEZA','J',12345678917);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232911', '1980-03-08', 'Bruno da Silva', 'SUP_LIMPEZA','P',null);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1990-09-10', 'Eugenia da Silva', 'LIMPEZA','J',12345678919);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '1980-02-12', 'Luciano da Silva', 'SUP_LIMPEZA','S',null);

ALTER TABLE tarefas ADD CONSTRAINT cpf_funcionario FOREIGN KEY (func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE CASCADE;

SELECT * FROM tarefas;

DELETE FROM funcionario WHERE cpf = '32323232911';

ALTER TABLE tarefas DROP CONSTRAINT cpf_funcionario;

ALTER TABLE tarefas ADD CONSTRAINT cpf_funcionario FOREIGN KEY (func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE RESTRICT;

DELETE FROM funcionario WHERE cpf = '98765432111';
retorna = ERROR:  update or delete on table "funcionario" violates foreign key constraint "cpf_funcionario" on table "tarefas"
DETAIL:  Key (cpf)=(98765432111) is still referenced from table "tarefas".

--Questao 11
ALTER TABLE tarefas DROP CONSTRAINT cpf_funcionario;

ALTER TABLE tarefas ALTER COLUMN func_resp_cpf DROP NOT NULL;

ALTER TABLE tarefas ADD CONSTRAINT cpf_funcionario FOREIGN KEY (func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE SET NULL;

ALTER TABLE tarefas ADD CONSTRAINT status_null CHECK (status = 'C' AND func_resp_cpf IS NOT NULL OR status = 'E' AND  func_resp_cpf IS NOT NULL OR status = 'P');

DELETE FROM funcionario WHERE cpf = '98765432111';
ERROR:  new row for relation "tarefas" violates check constraint "status_null"
DETAIL:  Failing row contains (2147483646, limpar chao do corredor central, null, 0, C).
CONTEXT:  SQL statement "UPDATE ONLY "public"."tarefas" SET "func_resp_cpf" = NULL WHERE $1 OPERATOR(pg_catalog.=) "func_resp_cpf""

INSERT INTO tarefas VALUES(2147483649, 'limpar portas dos fundos', '12345678911', 2, 'E');

DELETE FROM funcionario WHERE cpf = '12345678911';
ERROR:  update or delete on table "funcionario" violates foreign key constraint "cpf_superior" on table "funcionario"
DETAIL:  Key (cpf)=(12345678911) is still referenced from table "funcionario".

DELETE FROM funcionario WHERE cpf = '32323232955';

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

ALTER TABLE ONLY public.funcionario DROP CONSTRAINT cpf_superior;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT cpf_funcionario;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefas_id_key;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: holliverdoc
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date NOT NULL,
    nome text NOT NULL,
    funcao text NOT NULL,
    nivel character(1) NOT NULL,
    superior_cpf character(11),
    CONSTRAINT limpeza_check CHECK ((((funcao = 'LIMPEZA'::text) AND (superior_cpf IS NOT NULL)) OR (funcao = 'SUP_LIMPEZA'::text))),
    CONSTRAINT nivel_valido CHECK (((nivel = 'J'::bpchar) OR (nivel = 'P'::bpchar) OR (nivel = 'S'::bpchar)))
);


ALTER TABLE public.funcionario OWNER TO holliverdoc;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: holliverdoc
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao text NOT NULL,
    func_resp_cpf character(11),
    prioridade smallint NOT NULL,
    status character(1) NOT NULL,
    CONSTRAINT prioridade_valida CHECK (((prioridade < 6) OR (prioridade >= 0))),
    CONSTRAINT status_null CHECK ((((status = 'C'::bpchar) AND (func_resp_cpf IS NOT NULL)) OR ((status = 'E'::bpchar) AND (func_resp_cpf IS NOT NULL)) OR (status = 'P'::bpchar))),
    CONSTRAINT status_valido CHECK (((status = 'P'::bpchar) OR (status = 'E'::bpchar) OR (status = 'C'::bpchar)))
);


ALTER TABLE public.tarefas OWNER TO holliverdoc;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: holliverdoc
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1990-04-08', 'Maria da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678914', '1975-05-18', 'Holliver da Silva', 'LIMPEZA', 'J', '12345678913');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678915', '1960-07-28', 'Joao da Silva', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678916', '1977-05-10', 'Maisa da Silva', 'LIMPEZA', 'J', '12345678915');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678917', '1970-01-01', 'Helder da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678918', '1976-03-30', 'Brenda da Silva', 'LIMPEZA', 'J', '12345678917');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678919', '1980-03-08', 'Rebeca da Silva', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678920', '1990-09-10', 'Herbet da Silva', 'LIMPEZA', 'J', '12345678919');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678921', '1980-02-12', 'Luciana da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678922', '1990-11-02', 'Djalma da Silva', 'LIMPEZA', 'J', '12345678921');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '1980-02-12', 'Luciano da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1990-09-10', 'Eugenia da Silva', 'LIMPEZA', 'J', '12345678919');


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: holliverdoc
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483646, 'limpar chao do corredor central', '98765432111', 0, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483649, 'limpar portas dos fundos', '12345678911', 2, 'E');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483648, 'limpar portas do terreo', NULL, 4, 'P');


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: tarefas_id_key; Type: CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_id_key UNIQUE (id);


--
-- Name: cpf_funcionario; Type: FK CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT cpf_funcionario FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE SET NULL;


--
-- Name: cpf_superior; Type: FK CONSTRAINT; Schema: public; Owner: holliverdoc
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT cpf_superior FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- PostgreSQL database dump complete
--

