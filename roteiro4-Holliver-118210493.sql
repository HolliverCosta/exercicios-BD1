--Q1
SELECT * FROM department;
--Q2
SELECT * FROM dependent;
--Q3
SELECT * FROM dept_locations ;
--Q4
SELECT * FROM employee;
--Q5
SELECT * FROM project;
--Q6
SELECT * FROM works_on;
--Q7
SELECT E.fname,E.lname FROM employee AS E WHERE E.sex = 'M';
--Q8
SELECT E.fname FROM employee AS E WHERE E.sex = 'M' AND E.superssn IS NULL;
--Q9
SELECT E.fname,S.fname FROM employee AS E , employee AS S WHERE E.superssn = S.ssn;
--Q10
SELECT E.fname FROM employee AS E WHERE E.superssn = '333445555';
--Q11
SELECT D.dname,L.dlocation FROM department AS D, dept_locations AS L WHERE D.dnumber = L.dnumber;
--Q12
SELECT D.dname FROM department AS D, dept_locations AS L WHERE D.dnumber = L.dnumber AND L.dlocation LIKE 'S%';
--Q13
SELECT E.fname,E.lname,D.dependent_name FROM employee AS E, dependent AS D WHERE D.essn = E.ssn;
--Q14
SELECT E.fname ||' '|| E.minit ||' '|| E.lname AS full_name, E.salary FROM employee AS E WHERE E.salary > '50000';
--Q15
SELECT P.pname, D.dname FROM project AS P, department AS D WHERE P.dnum = D.dnumber;
--Q16
SELECT P.pname,E.fname FROM project AS P, employee AS E, department AS D WHERE P.dnum = D.dnumber AND P.pnumber > 30 AND D.mgrssn = E.ssn;
--Q17
SELECT P.pname,E.fname FROM project AS P, employee AS E, works_on AS W WHERE W.essn = E.ssn AND W.pno = P.pnumber;
--Q18
SELECT E.fname, D.dependent_name, D.relationship FROM employee AS E, works_on AS W, dependent AS D WHERE D.essn = E.ssn AND W.essn = E.ssn AND W.pno = '91';
