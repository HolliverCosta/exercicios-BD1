--Questão 1 
--Letra A
CREATE VIEW vw_dptmgr AS SELECT D.dnumber, E.fname FROM employee AS E,department AS D WHERE D.mgrssn = E.ssn;
--Letra B
CREATE VIEW vw_empl_houston AS SELECT E.ssn, E.fname FROM employee AS E wHERE E.address LIKE '%Houston%';
--Letra C
CREATE VIEW vw_deptstats AS SELECT D.dnumber,D.dname, COUNT(*) FROM employee AS E,department AS D WHERE D.dnumber = E.dno GROUP BY D.dnumber; 
--Letra D
CREATE VIEW vw_projstats AS SELECT W.pno ,COUNT(W.pno) FROM works_on AS W GROUP BY W.pno; 

--Questão 2
SELECT * FROM vw_dptmgr;
SELECT * FROM vw_empl_houston;
SELECT * FROM vw_deptstats;
SELECT * FROM vw_projstats;

--Questão 3
DROP VIEW vw_dptmgr;
DROP VIEW vw_empl_houston;
DROP VIEW vw_deptstats;
DROP VIEW vw_projstats;

--Questão 4 
CREATE FUNCTION check_age(ssn_empregado CHAR(9))
RETURNS VARCHAR(7) AS $$

DECLARE idade_empregado INTEGER;

BEGIN
	SELECT EXTRACT (YEAR FROM AGE(E.bdate)) INTO idade_empregado FROM employee AS E WHERE E.ssn = ssn_empregado;
	IF idade_empregado >= 50 THEN RETURN 'SENIOR';
	ELSEIF idade_empregado < 0 THEN RETURN 'INVALID';
	ELSEIF idade_empregado  < 50 THEN RETURN 'YOUNG';
	ELSEIF idade_empregado IS NULL THEN RETURN 'UNKOWN';
	
	END IF;
END;

$$ LANGUAGE plpgsql;

--Questão 5

--função para verificar quando não for um funcionário atualmente alocado no departamento
CREATE OR REPLACE FUNCTION check_alocado_departamento(ssn_empregado CHAR(9), dnumber_departamento INTEGER)
RETURNS BOOLEAN AS $$

DECLARE dno_employee INTEGER;

BEGIN
	SELECT E.dno INTO dno_employee FROM employee AS E WHERE E.ssn = ssn_empregado;
	IF dno_employee = dnumber_departamento THEN RETURN TRUE;
	ELSE RAISE EXCEPTION 'manager must be a department"s employee';
	END IF;
END;

$$ LANGUAGE plpgsql;

--função para verifiicar o mgr não possui subordinados

CREATE OR REPLACE FUNCTION check_subordinado(ssn_empregado CHAR(9))
RETURNS BOOLEAN AS $$

DECLARE empregado_superssn CHAR(9);

BEGIN
	SELECT E.superssn INTO empregado_superssn FROM employee AS E WHERE E.superssn = ssn_empregado;
	IF empregado_superssn IS NOT NULL THEN RETURN TRUE;
	ELSE RAISE EXCEPTION 'manager must have supevisees';
	END IF;
END;

$$ LANGUAGE plpgsql;

--função para verificar se é senior 
CREATE OR REPLACE FUNCTION check_senior(ssn_empregado CHAR(9))
RETURNS BOOLEAN AS $$

DECLARE empregado_senior VARCHAR(7);

BEGIN
	SELECT check_age(ssn_empregado) INTO empregado_senior;
	IF empregado_senior = 'SENIOR' THEN RETURN TRUE;
	ELSE RAISE EXCEPTION 'manager must be a SENIOR employee';
	END IF;
END;

$$ LANGUAGE plpgsql;

--as 3 funções juntas 
CREATE OR REPLACE FUNCTION check_mgr()
 	RETURNS trigger AS
    $check_mgr$

	BEGIN
		PERFORM check_alocado_departamento(NEW.mgrssn, NEW.dnumber);
		PERFORM check_subordinado(NEW.mgrssn);
		PERFORM check_senior(NEW.mgrssn);
	END;
    $check_mgr$ LANGUAGE plpgsql;

--trigger 
 CREATE TRIGGER check_mgr BEFORE INSERT OR UPDATE ON department
        FOR EACH ROW EXECUTE PROCEDURE check_mgr();
		