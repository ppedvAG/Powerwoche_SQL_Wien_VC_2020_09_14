-- VIEW WITH CHECK OPTION

USE Northwind

CREATE TABLE Helden (
						firstname varchar(30),
						lastname varchar(30),
						age int
					)


INSERT INTO Helden (firstname, lastname, age)
VALUES ('James', 'Bond', 40),
	   ('Bruce', 'Wayne', 35),
	   ('Peter', 'Parker', 23)


SELECT *
FROM Helden

CREATE VIEW vHelden
AS
SELECT	  firstname
		, lastname
		, age
FROM Helden
WHERE age IS NOT NULL


INSERT INTO Helden (firstname, lastname, age)
VALUES ('Clark', 'Kent', 26)


SELECT *
FROM vHelden


INSERT INTO Helden (firstname, lastname, age)
VALUES ('Obi Wan', 'Kenobi', NULL)

SELECT *
FROM Helden

SELECT *
FROM vHelden

INSERT INTO vHelden (firstname, lastname, age)
VALUES ('Pluto', 'Mouse', NULL)


SELECT *
FROM vHelden


SELECT *
FROM Helden


INSERT INTO vHelden (firstname, lastname, age)
VALUES ('Luke', 'Skywalker', 18)


DROP VIEW vHelden

CREATE VIEW vHelden
AS
SELECT	  firstname
		, lastname
		, age
FROM Helden
WHERE age IS NOT NULL
WITH CHECK OPTION


INSERT INTO vHelden (firstname, lastname, age)
VALUES ('Mickey', 'Mouse', 42)


INSERT INTO vHelden (firstname, lastname, age)
VALUES ('Minnie', 'Mouse', NULL)


-- in die Helden Tabelle dürfen wir natürlich immer noch NULL-Werte einfügen
INSERT INTO Helden (firstname, lastname, age)
VALUES ('Minnie', 'Mouse', NULL)


SELECT *
FROM Helden

SELECT *
FROM vHelden