-- Indices, Indizes, (Indexe)
-- indexes

-- clustered index (gruppierter Index)
		-- 1 pro Tabelle
		-- verantwortlich für wo die Daten physisch abgespeichert werden
-- nonclustered index (nicht gruppierter Index)
		-- unique index (eindeutiger Index)
		-- multicolumn index (zusammengesetzter Index)
		-- covering index (abdeckender Index)
		-- filtered index (gefilterter Index)
		-- index with included columns (Index mit eingeschlossenen Spalten)
		-- hypothetisch realer Index


-- columnstore Index


-- DB speichert in HEAP (Haufen)

-- Speichereinheit der Datenbank: page
-- page hat 8MB
-- 8192 byte, davon sind theoretisch 8060 byte für uns zur Datenspeicherung zur Verfügung





-- Verweise, wo wir die Daten finden
-- > es müssen nicht mehr alle Seiten durchsucht werden
-- wie bei einem Index im Lexikon: wir bekommen einen Verweis darauf, wo wir die Daten finden, die wir suchen


-- welche Indices sind in der aktuellen DB vorhanden?
SELECT * FROM sys.indexes


SELECT  cust.CustomerID
		, cust.CompanyName
		, cust.ContactName
		, cust.ContactTitle
		, cust.City
		, cust.Country
		, ord.EmployeeID
		, ord.OrderDate
		, ord.freight
		, ord.shipcity
		, ord.shipcountry
		, ods.OrderID
		, ods.ProductID
		, ods.UnitPrice
		, ods.Quantity
		, prod.ProductName
		, emp.LastName
		, emp.FirstName
		, emp.birthdate
into dbo.KundenUmsatz
FROM	Customers AS cust
		INNER JOIN Orders AS ord ON cust.CustomerID = ord.CustomerID
		INNER JOIN Employees AS emp ON ord.EmployeeID = emp.EmployeeID
		INNER JOIN [Order Details] AS ods ON ord.orderid = ods.orderid
		INNER JOIN Products AS prod ON ods.productid = prod.productid

-- Multiplikation für großen Datenbestand
-- solange bis ~ 1.100.000 erreicht sind > ~ 400 MB Größe

insert into dbo.KundenUmsatz
select * from dbo.KundenUmsatz
GO 9								-- 9 Wiederholungen

select COUNT(*) from KundenUmsatz

-- Multiplikation für großen Datenbestand
-- solange bis ~ 1.100.000 erreicht sind > ~ 400 MB Größe

insert into dbo.KundenUmsatz
select * from dbo.KundenUmsatz
GO 9								-- 9 Wiederholungen

select COUNT(*) from dbo.KundenUmsatz

SELECT *
INTO ku2
FROM KundenUmsatz

SELECT * FROM ku2


SELECT TOP 3 * FROM ku2
-- mit Top gehts schneller, weil man damit logische Lesevorgänge abkürzt


set statistics io, time on

ALTER TABLE ku2 
ADD kid int IDENTITY


SELECT kid
FROM ku2
WHERE kid = 1000


--CREATE NONCLUSTERED INDEX IX_Name
--ON Tabelle (Spalte)



SELECT kid
FROM ku2
WHERE kid = 1000

-- wir durchsuchen dank Index nur noch 3 Seiten (statt über 50.000)
-- Index Seek: ein Index hat uns genau zur gesuchten Information geführt


-- zusätzliche Spalte auswählen:
SELECT    kid
		, CompanyName
FROM ku2
WHERE kid = 1000

-- CompanyName ist Lookup (Heap) - wie ein Scan

-- neuer Index für diese Anforderung


SELECT kid
FROM ku2
WHERE kid = 1000


-- noch mehr Spalten:
SELECT	  kid
		, CompanyName
		, Country
		, City
FROM ku2
WHERE kid = 1000

-- neuer Index
-- covered/covering Index (abdeckender Index) wenn alle Spalten in der Abfrage von einem Index erfasst werden



