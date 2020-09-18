-- Subquery, Subselect, Unterabfragen

-- Subselect wie Spalte, wie Tabelle oder im WHERE verwenden m�glich


-- Subquery wie Spalte verwenden:

SELECT    'Text'
		, Freight
--      , ...
		, (SELECT TOP 1 Freight FROM Orders ORDER BY Freight)
FROM Orders
-- wenn Subquery im SELECT, wenn es also wie eine Spalte verwendet wird, darf nur 1 Wert drin stehen


-- Subselect wie Tabelle verwenden
SELECT *
FROM -- aus welcher Tabelle kommt die Information?
		(SELECT OrderID, Freight FROM Orders WHERE EmployeeID = 3) AS t1

-- wenn Subquery als Datenquelle, dann m�ssen wir ein ALIAS vergeben (AS t1)
-- das "AS" d�rfen wir auch wieder weglassen
-- Namen k�nnen wir frei vergeben


-- Subquery im WHERE
-- alle Bestellungen, wo Frachtkosten gr��er als durchschnittliche Frachtkosten:
SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) -- 78,2442
-- hier muss auch ein konkreter Wert herauskommen, denn wir wollen ja �berpr�fen, ob die Frachtkosten gr��er sind als dieser Wert
-- hier k�nnen nicht mehrere Spalten herauskommen

--SELECT AVG(Freight)
--FROM Orders

-- auch mit AND m�glich:
SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) AND Freight < 200


SELECT *
FROM Orders
WHERE Freight < 200 AND Freight > (SELECT AVG(Freight) FROM Orders)



-- auch mehrere Subqueries w�ren m�glich, aber Sinn? ... und Performance :(
SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) AND Freight < (SELECT SUM(Freight) FROM Orders)



-- alle Kunden, die in einem Land wohnen, in das auch Bestellungen verschifft werden

-- langsam:
-- die L�nder, in die wir liefern?
SELECT Country
FROM Customers

SELECT ShipCountry
FROM Orders

-- alle Kunden:
SELECT	  CustomerID
		, CompanyName
		, Country
--		, ...
FROM Customers


-- zusammenbauen:
SELECT	  CustomerID
		, CompanyName
		, Country
--		, ...
FROM Customers
WHERE Country IN(SELECT DISTINCT ShipCountry FROM Orders)



-- Gib die SupplierID, den CompanyName, die Kontaktinformation und das Land aller Supplier aus, die aus dem gleichen Land sind wie der Supplier mit der ID 2.


-- in welchem Land wohnt der Supplier mit der ID 2?
SELECT	  Country
--		, SupplierID
FROM Suppliers
WHERE SupplierID = 2



SELECT	  SupplierID
		, CompanyName
		, ContactName
		, Phone
	--	, ...
		, Country
FROM Suppliers
WHERE Country = (SELECT Country FROM Suppliers WHERE SupplierID = 2) -- USA




-- Gib die Namen und das Einstellungsdatum der Mitarbeiter aus, die im selben Jahr eingestellt wurden wie Mr. Robert King.
--Titel, Vorname und Nachname sollen �berpr�ft werden.
--Uhrzeit soll nicht mit ausgegeben werden

-- langsam:
-- in welchem Jahr ist der Robert King eingestellt worden?
SELECT YEAR(HireDate)
FROM Employees
WHERE FirstName = 'Robert' AND LastName = 'King' AND TitleOfCourtesy = 'Mr.'


-- wie bekomme ich alle Angestellten, die 1994 eingestellt wurden
SELECT	  FirstName
		, LastName
		, TitleOfCourtesy
		, FORMAT(HireDate, 'dd.MM.yyyy')
FROM Employees
WHERE YEAR(HireDate) = 1994


-- zusammenf�gen:
SELECT	  FirstName
		, LastName
		, TitleOfCourtesy
		, FORMAT(HireDate, 'dd.MM.yyyy')
FROM Employees
WHERE YEAR(HireDate) = (SELECT YEAR(HireDate) FROM Employees
WHERE FirstName = 'Robert' AND LastName = 'King' AND TitleOfCourtesy = 'Mr.')


-- wenn Robert King selbst nicht dabei stehen soll:
SELECT	  FirstName
		, LastName
		, TitleOfCourtesy
		, FORMAT(HireDate, 'dd.MM.yyyy')
FROM Employees
WHERE YEAR(HireDate) = (SELECT YEAR(HireDate) FROM Employees
WHERE FirstName = 'Robert' AND LastName = 'King' AND TitleOfCourtesy = 'Mr.') AND EmployeeID != 7