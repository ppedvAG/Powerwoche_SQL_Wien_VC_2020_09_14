-- Sequence
-- ab SQL Server 2012



-- neue Sequenz erstellen:
CREATE SEQUENCE my_sq1
START WITH 1
INCREMENT BY 1




-- zugreifen auf Sequenz:
-- Möglichkeit 1:
CREATE TABLE TestSeq1 (
						ID int PRIMARY KEY DEFAULT (NEXT VALUE FOR my_sq1),
						TestName varchar(30),
						TestNumber int
						)


INSERT INTO TestSeq1 (TestName, TestNumber)
VALUES ('James', 1234),
	   ('Mike', 5678)

SELECT *
FROM TestSeq1


CREATE SEQUENCE my_seq2
START WITH 1
INCREMENT BY 1


-- Möglichkeit 2:


CREATE TABLE TestSeq2 (
						ID int PRIMARY KEY,
						TestName varchar(30),
						TestNumber int
						) 


INSERT INTO TestSeq2 (ID, TestName, TestNumber)
VALUES (NEXT VALUE FOR my_seq2, 'James', 1234),
	   (NEXT VALUE FOR my_seq2, 'Mike', 5678),
	   (NEXT VALUE FOR my_seq2, 'Leo', 09876),
	   (NEXT VALUE FOR my_seq2, 'Chris', 4567),
	   (NEXT VALUE FOR my_seq2, 'Anna', 098765)

SELECT *
FROM TestSeq2