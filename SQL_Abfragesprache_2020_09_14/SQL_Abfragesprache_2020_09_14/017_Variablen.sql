-- Variablen

/*
	-- lokale Variablen
	-- Zugriff nur in der Session, in der sie erstellt wurde
	-- @varname

	-- globale Variablen
	-- Zugriff auch von außerhalb der Session
	-- @@varname

	-- Lebenszeit: nur, solange der Batch läuft

	-- Variable deklarieren
	-- welchen Datentyp soll die Variable bekommen

	-- Wert zuweisen

*/


-- Bsp.:

-- deklarieren
DECLARE @var1 AS int

-- Wert zuweisen:
SET @var1 = 100

SELECT @var1


DECLARE @myDate datetime2 = SYSDATETIME()
SELECT FORMAT(@myDate, 'd', 'de-de')



DECLARE @freight AS money = 50
SELECT *
FROM Orders
WHERE Freight > @freight