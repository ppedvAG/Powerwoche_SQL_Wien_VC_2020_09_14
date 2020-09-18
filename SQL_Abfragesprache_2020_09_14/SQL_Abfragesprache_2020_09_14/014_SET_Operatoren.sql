-- SET Operatoren

-- UNION, UNION ALL, INTERSECT, EXCEPT






-- Liste von allen Kontaktpersonen
-- ContactName, Phone

-- mit einem JOIN bekommen wir keine Liste, sondern 4 Spalten (Name, Phone, Name, Phone,...)
-- mit INNER JOIN bekommen wir außerdem nur die Customers, die schon etwas bestellt haben und die Suppliers, die schon etwas geliefert haben!


-- UNION

SELECT 'Testtext1'
UNION
SELECT 'Testtext2'


-- UNION macht auch ein DISTINCT!
SELECT 'Testtext'
UNION
SELECT 'Testtext'


-- wenn wir doppelte Ergebnisse angezeigt bekommen möchten: UNION ALL
SELECT 'Testtext'
UNION ALL
SELECT 'Testtext'

-- UNION ALL ist auch schneller als UNION, weil keine Überprüfung stattfinden muss, ob es ein Ergebnis schon gibt


-- Vorsicht:
-- funktioniert nicht:
SELECT 123
UNION
SELECT 'Testtext'
-- Conversion failed when converting the varchar value 'Testtext' to data type int.
-- wir müssen gleiche (bzw. kompatible) Datentypen in einer Spalte haben

-- wir könnten explizit konvertieren... Sinn? (von Fall zu Fall entscheiden)
SELECT CAST(123 AS varchar)
UNION
SELECT 'Testtext'


-- funktioniert nicht:
SELECT 123, 'Testtext'
UNION
SELECT 'Testtext2'
-- All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.

-- wir müssen in den beteiligten SELECT-Statements gleich viele Spalten haben

-- funktioniert:
SELECT 123, 'Testtext'
UNION
SELECT 456, 'Testtext2'



-- funktioniert:
SELECT 123, 'Testtext'
UNION
SELECT 456, NULL

-- wir dürfen weitere Spalten mit NULL auffüllen
-- SINN? Von Fall zu Fall entscheiden!



SELECT    123 AS Zahl
	   , 'Testtext' AS MyText
UNION
SELECT	  456 AS Test
		, 'Testtext2' AS Test2
-- Überschriften: reicht beim 1. SELECT, das ist die Spaltenüberschrift für alle, die da noch folgen, weitere/andere werden ignoriert




-- Liste von Kontaktdaten?
-- CompanyName, ContactName, Phone
-- Customers und Suppliers
SELECT	  CompanyName
		, ContactName
		, Phone
FROM Customers
UNION
SELECT	  CompanyName
		, ContactName
		, Phone
FROM Suppliers


SELECT	  CompanyName
		, ContactName
		, Phone
		, CustomerID -- nchar
FROM Customers
UNION
SELECT	  CompanyName
		, ContactName
		, Phone
		, SupplierID -- int
FROM Suppliers
-- Conversion failed when converting the nvarchar value 'ALFKI' to data type int.
-- Problem: wir brauchen gleichen/kompatible Datentypen in einer Spalte!


-- können wir trotzdem die ID in eine Spalte schreiben?
SELECT	  CompanyName
		, ContactName
		, Phone
		, CustomerID 
FROM Customers
UNION
SELECT	  CompanyName
		, ContactName
		, Phone
		, CAST(SupplierID AS varchar)
FROM Suppliers


-- UNION ALL wäre hier schneller (und macht auch Sinn, weil wir keine doppelten Kontaktpersonen in der DB haben)
SELECT	  CompanyName
		, ContactName
		, Phone
		, CustomerID 
FROM Customers
UNION ALL
SELECT	  CompanyName
		, ContactName
		, Phone
		, CAST(SupplierID AS varchar)
FROM Suppliers


-- ORDER BY:
SELECT	  CompanyName
		, ContactName
		, Phone
		, CustomerID 
FROM Customers
UNION ALL
SELECT	  CompanyName
		, ContactName
		, Phone
		, CAST(SupplierID AS varchar)
FROM Suppliers
ORDER BY CompanyName

-- ORDER BY funktioniert, gilt aber für ALLE!
-- wir können nicht vor dem UNION ein ORDER BY machen, sondern nur am Ende (sortiert die gesamte Ausgabe)
-- Spaltenüberschriften müssen nicht gleich sein, aber der darin enthaltene Datentyp muss gleich/kompatibel sein





-- "ABC-Analyse":
SELECT	  CompanyName
		, ContactName
		, Phone
		, 'C' AS Category
FROM Customers
UNION ALL
SELECT	  CompanyName
		, ContactName
		, Phone
		, 'S' -- AS 'Category' -- optional (steht ja schon oben dabei)
FROM Suppliers
ORDER BY CompanyName




SELECT	  CompanyName
		, ContactName
		, Phone
FROM Customers
UNION
SELECT	  CompanyName
		, ContactName
		, 'blabla' -- wir dürfen anderen Text reinschreiben - Sinn?? Wieder von Fall zu Fall entscheiden
FROM Suppliers




SELECT	  Region
		, ContactName
		, Phone
FROM Customers
UNION ALL
SELECT	  Region
		, CONCAT(FirstName, ' ', LastName) -- wird in 1 Spalte zusammengefasst
		, HomePhone
FROM Employees


-- Liste mit niedrigsten und höchsten Frachtkosten (untereinander)
-- OrderID, Freight, 'niedrigste Frachtkosten'
-- OrderID, Freight, 'höchste Frachtkosten'


-- mit Aggregatsfunktion....
SELECT	  MIN(Freight) AS Freight
		, 'niedrigste Frachtkosten'
FROM Orders
UNION ALL
SELECT    MAX(Freight) 
		, 'höchste Frachtkosten'
FROM Orders
-- ...ohne OrderID funktioniert es


-- wir können ein GROUP BY machen...
SELECT	  MIN(Freight) AS Freight
		, 'niedrigste Frachtkosten'
		, OrderID
FROM Orders
GROUP BY OrderID
UNION ALL
SELECT    MAX(Freight) 
		, 'höchste Frachtkosten'
		, OrderID
FROM Orders
GROUP BY OrderID
-- ... aber dann bekommen wir den min/max-Wert pro OrderID (1660 Ergebnisse), der ja wieder genau den eigentlichen Frachtkosten entspricht
--> sinnlos



SELECT TOP 1
			  OrderID
			, Freight
			, 'niedrigste Frachtkosten'
FROM Orders
ORDER BY Freight
UNION ALL -- funktioniert nicht wegen ORDER BY - das untere gilt für alle!
SELECT TOP 1
			  OrderID
			, Freight
			, 'höchsten Frachtkosten'
FROM Orders
ORDER BY Freight DESC



-- mit temporärer Tabelle funktioniert es:
SELECT TOP 1
			  OrderID
			, Freight
			, 'niedrigste Frachtkosten' AS Wert
INTO #n
FROM Orders
ORDER BY Freight

SELECT TOP 1
			  OrderID
			, Freight
			, 'höchsten Frachtkosten' AS Wert
INTO #h
FROM Orders
ORDER BY Freight DESC


SELECT *
FROM #n
UNION
SELECT *
FROM #h
-- ORDER BY Freight -- hier dürften wir wieder ein ORDER BY machen (gilt für beide)




-- INTERSECT, EXCEPT und Überblick

CREATE TABLE #a (id int)

CREATE TABLE #b (id int)

INSERT INTO #a(id) VALUES (1), (NULL), (2), (1)

INSERT INTO #b(id) VALUES (1), (NULL), (3), (1)


SELECT * FROM #a
SELECT * FROM #b


-- UNION
SELECT id
FROM #a
UNION
SELECT id
FROM #b
-- NULL, 1, 2, 3
-- UNION macht auch DISTINCT


-- UNION ALL
SELECT id
FROM #a
UNION ALL
SELECT id
FROM #b
-- 1, NULL, 2, 1, 1, NULL, 3, 1


-- INTERSECT: was ist gleich?
SELECT id
FROM #a
INTERSECT
SELECT id
FROM #b
-- NULL, 1


-- EXCEPT: was ist NICHT gleich?
SELECT id
FROM #a
EXCEPT
SELECT id
FROM #b
-- 2
-- das, was in Tabelle #a vorkommt, aber nicht in Tabelle #b

-- in umgekehrter Reihenfolge:
SELECT id
FROM #b
EXCEPT
SELECT id
FROM #a
-- 3
-- das, was in Tabelle #b vorkommt, aber nicht in Tabelle #a


-- INNER JOIN
SELECT a.id
FROM #a a INNER JOIN #b b ON a.id = b.id
-- 1, 1, 1, 1


-- LEFT JOIN
SELECT a.id
FROM #a a LEFT JOIN #b b ON a.id = b.id
-- 1, 1, NULL, 2, 1, 1


-- RIGHT JOIN
SELECT a.id
FROM #a a RIGHT JOIN #b b ON a.id = b.id
-- 1, 1, NULL, NULL, 1, 1