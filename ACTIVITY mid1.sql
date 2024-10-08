SELECT 		E1.WORKDEPT, D.DEPTNAME, E1.BIRTHDATE AS EMP_DOB, E1.HIREDATE AS EMP_HIREDATE, E2.HIREDATE AS MGR_HIREDATE
FROM 		EMPLOYEE E1
JOIN 		DEPARTMENT D 
	ON 		E1.WORKDEPT = D.DEPTNO
JOIN 		EMPLOYEE E2 
	ON 		D.MGRNO = E2.EMPNO
WHERE 		E1.BIRTHDATE > E2.BIRTHDATE
	AND 	E1.HIREDATE < E2.HIREDATE
	AND 	(D.DEPTNAME LIKE '%CENTER%' OR D.DEPTNAME LIKE '%SYSTEMS%')
ORDER BY 	D.DEPTNAME, E1.LASTNAME;



SELECT 		E.WORKDEPT, D.DEPTNAME, E.LASTNAME AS EMPLOYEE, E.BIRTHDATE AS "EMP-DOB", E.HIREDATE, M.LASTNAME AS MANAGER, M.BIRTHDATE AS "MGR-DOB", M.HIREDATE
FROM   		EMPLOYEE E JOIN DEPARTMENT D
	ON 		E.WORKDEPT = D.DEPTNO
	JOIN EMPLOYEE M
	ON D.MGRNO = E.EMPNO
WHERE E.BIRTHDATE > M.BIRTHDATE
	AND E.HIREDATE < M.HIREDATE
	AND (D.DEPTNAME LIKE '%CENTER%' OR D.DEPTNAME LIKE '%SYSTEMS%')
ORDER BY D.DEPTNAME, E.LASTNAME;


2.
SELECT D.DEPTNO, D.DEPTNAME, EA.ACTNO, P.PROJNAME, E.EMPNO, E.LASTNAME, 
   CASE E.GENDER
	   WHEN 'M' THEN 'MALE'
	   WHEN 'F' THEN 'FEMALE'
   END AS GENDER,
   CASE 
	   WHEN E.GENDER = 'M' THEN
		   CASE E.EDLEVEL
			   WHEN '12' THEN 'High School'
			   WHEN '14' THEN 'Associate Degree'
			   WHEN '16' THEN 'Bachelor\'s Degree'
			   WHEN '18' THEN 'Master\'s Degree'
			   ELSE 'Other'
		   END
	   ELSE NULL
   END AS "APPLICATION_LEVEL"
FROM 		EMP_ACT EA JOIN EMPLOYEE E 
	ON 		EA.EMPNO = E.EMPNO JOIN PROJECT P 
	ON  EA.PROJNO = P.PROJNO JOIN DEPARTMENT D 
	ON P.DEPTNO = D.DEPTNO
WHERE 		EA.EMSTDATE >= '2017-03-20'
	AND 	EA.EMSTDATE <= '2020-01-15'
	AND EA.ACTNO % 3 = 0
ORDER BY 	D.DEPTNO ASC, EA.ACTNO DESC;





SELECT 		D.DEPTNO, D.DEPTNAME, E.EMPNO, E.LASTNAME, E.FIRSTNAME, E.JOB, (E.SALARY + COALESCE(E.BONUS, 0) + COALESCE(E.COMM, 0)) AS TOTAL_INCOME
FROM 		EMPLOYEE E
JOIN 		DEPARTMENT D 
	ON 		E.WORKDEPT = D.DEPTNO
WHERE 		E.JOB NOT IN ('President', 'Manager')
	AND 		(E.SALARY + COALESCE(E.BONUS, 0) + COALESCE(E.COMM, 0)) IS NOT NULL
ORDER BY 	D.DEPTNO ASC, TOTAL_INCOME DESC
LIMIT 		15;
