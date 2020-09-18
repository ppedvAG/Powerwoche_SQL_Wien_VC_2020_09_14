-- temporäre Tabellen
-- temporary tables


/*
	-- lokale temporäre Tabellen
	-- existieren nur in der aktuellen Session
	-- #tablename




	-- globale temporäre Tabellen
	-- Zugriff auch von anderen Sessions aus
	-- ##tablename


	-- hält nur so lange, wie Verbindung da ist/Session offen ist
	-- kann auch gelöscht werden


*/

SELECT CustomerID, Freight
INTO #t1
FROM Orders


SELECT *
FROM #t1


SELECT OrderID, OrderDate
INTO ##t2
FROM Orders


SELECT *
FROM ##t2