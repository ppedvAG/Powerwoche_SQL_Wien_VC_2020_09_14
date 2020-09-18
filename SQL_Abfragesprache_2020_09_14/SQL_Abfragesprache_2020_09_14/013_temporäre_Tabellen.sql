-- tempor�re Tabellen
-- temporary tables


/*
	-- lokale tempor�re Tabellen
	-- existieren nur in der aktuellen Session
	-- #tablename




	-- globale tempor�re Tabellen
	-- Zugriff auch von anderen Sessions aus
	-- ##tablename


	-- h�lt nur so lange, wie Verbindung da ist/Session offen ist
	-- kann auch gel�scht werden


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