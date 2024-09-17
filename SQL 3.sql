USE Galvez_DB

CREATE TABLE COLLEGE (
	COLCODE CHAR(5) PRIMARY KEY,
	COLNAME VARCHAR(50), 
);

INSERT INTO COLLEGE
VALUES
('BSCOM', 'COLLEGE OF COMMERCE AND ACCOUNTANCY'),
('BSCOE', 'COLLEGE OF COMPUTER ENGINEERING'),
('BSICS', 'COLLEGE OF INFO. AND COMP STUDIES'),
('BSENG', 'COLLEGE OF ALLIED ENGINEERING'),
('BSEDU', 'COLLEGE OF EDUCATION'),
('BSCRM', 'COLLEGE OF CRIMINAL JUSTICE'),
('BSCAD', 'COLLEGE OF CUSTOMS ADMINISTRATION');

CREATE TABLE FACULTY (
	FID SMALLINT PRIMARY KEY,
	FNAME VARCHAR(50),
	GENDER CHAR(1) CHECK (GENDER IN('M','F')),
	AGE SMALLINT,
	HIREDATE DATE,
	RANK VARCHAR(10),
	COLCODE CHAR(5),
	FOREIGN KEY(COLCODE) REFERENCES COLLEGE(COLCODE)
);

INSERT INTO FACULTY (FID, FNAME, GENDER, AGE, HIREDATE, RANK, COLCODE)
VALUES
(115, 'MELVIN NI�AL', NULL, 30, '2009-06-01', 'DEAN', 'BSICS'),
(110, 'BELL CAMPANILLA', 'M', 32, '2003-06-15', 'INST', 'BSICS'),
(101, 'BEN ORDE�IZA', 'M', 51, '1980-10-01', 'INST', 'BSICS'),
(107, 'FRANZ CAMINADE', 'M', 38, '1997-06-15', 'INST', 'BSICS'),
(105, 'JONATHAN ETCUBAN', NULL, 35, '2000-03-01', 'INST', 'BSICS'),
(109, 'LEAH YBA�EZ', 'F', 32, '1995-06-01', 'INST', 'BSICS'),
(103, 'ROMEO DE LA VICTORIA', 'M', 46, '1986-03-15', 'INST', 'BSICS'),
(217, 'YUVINIA PINO', 'F', 50, '1983-03-01', 'INST', 'BSEDU'),
(150, 'ROSE CASTILLO', 'F', 49, '1981-06-15', 'INST', NULL),
(201, 'LEODIGARIO GATCHO', 'M', 43, '1988-06-01', 'INST', 'BSCOE'),
(210, 'CECELIO ESTOCINING', 'M', 52, '1986-03-15', 'INST', NULL),
(152, 'MARCIAL TIU', NULL, 54, '1980-06-01', 'INST', NULL),
(213, 'BEN VENTIC', 'M', 58, '1988-03-15', 'DEAN', NULL);

CREATE TABLE FACULTY_LOAD (
	SBJCODE CHAR(5) PRIMARY KEY,
	SBJTITLE VARCHAR(50),
	UNITS DECIMAL(2,1),
	FLOAD SMALLINT,
	FOREIGN KEY(FLOAD) REFERENCES FACULTY(FID)
);

INSERT INTO FACULTY_LOAD
VALUES
('IT110', 'IT FUNDAMENTALS', 3.0, 110),
('IT121', 'INTERNET PROGRAMMING', 3.0, NULL),
('IT210', 'COMP PROGRAMMING', 3.0, 101),
('IT212', 'QUALITY CONCIOUSNESS', 3.0, NULL),
('IT220', 'FILE ORG & PROCESSING', 3.0, 101),
('IT223', 'SYSTEM ANALYSIS & DESIGN', 3.0, 105),
('IT312', 'DATABASE SYSTEMS I', 4.0, 107),
('IT410', 'SOFTWARE ENGINEERING', 3.0, 105);


  
  
 12
SELECT F.FID, F.FNAME, FL.SBJCODE, FL.SBJTITLE, FL.UNITS, FL.SBJCODE 
FROM FACULTY F RIGHT OUTER JOIN FACULTY_LOAD FL 
	 ON F.FID = FL.FLOAD 
ORDER BY FL.SBJCODE;

13
SELECT F.FID, F.FNAME, F.RANK, C.COLCODE, C.COLNAME
FROM FACULTY F FULL OUTER JOIN COLLEGE C 
	 ON C.COLCODE = F.COLCODE
ORDER BY C.COLCODE;

14
SELECT F.FID, F.FNAME, F.RANK, FL.SBJCODE, FL.SBJTITLE
FROM FACULTY F LEFT OUTER JOIN FACULTY_LOAD FL 
	 ON FL.FLOAD = F.FID 
WHERE F.FID < 210 AND F.RANK != 'DEAN'
ORDER BY F.FID;

15
SELECT F.FID, F.FNAME, F.GENDER, F.RANK, FL.SBJCODE, FL.SBJTITLE, C.COLCODE, C.COLNAME
FROM FACULTY F  FULL OUTER JOIN FACULTY_LOAD FL 
	 ON FL.FLOAD = F.FID
				FULL OUTER JOIN COLLEGE C 
	 ON C.COLCODE = F.COLCODE
ORDER BY FL.SBJCODE;