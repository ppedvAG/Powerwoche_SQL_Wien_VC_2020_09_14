-- CAST, CONVERT, FORMAT
-- in welchem Datentyp wollen wir etwas ausgeben
-- in welchem Format


-- *************************** CAST ****************************************
-- Umwandeln von Datentypen

-- funktioniert:
SELECT '123' + 2
-- 125
-- die DB wandelt das für uns in einen int um


-- funktioniert nicht:
SELECT '123.5' + 2
-- Conversion failed when converting the varchar value '123.5' to data type int.

-- wir können aber explizit konvertieren (einen Datentyp in einen anderen umwandeln)
SELECT CAST('123.5' AS float) + 2
-- 125,5


/*
	Microsoft Dokumentation: implizite und explizite Konvertierung:
	
	https://docs.microsoft.com/de-de/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver15

*/


-- funktioniert auch mit Datum:
SELECT CAST(SYSDATETIME() AS varchar)
-- nur mit CAST alleine haben wir aber keinen Einfluss auf das Format
-- Format wieder systemabhängig

-- VORSICHT bei der Anzahl der Zeichen!
-- Geht sich das, was ich darstellen möchte, damit noch aus?
SELECT CAST(SYSDATETIME() AS varchar(3))
-- macht keinen Sinn!! -- 202


-- Vorsicht auch damit:
SELECT CAST('2020-09-17' AS date)
-- Achtung: systemabhängig, was als Tag und was als Monat interpretiert wird!
-- da könnte schlimmstenfalls auch der 9.17.2020 rauskommen


-- mit DB:
SELECT HireDate
FROM Employees


-- nur mit CAST allein kein Einfluss auf das Format:
SELECT CAST(HireDate AS varchar)
FROM Employees


-- ****************************** CONVERT **************************************
-- auch mit CONVERT wird ein Datentyp in einen anderen konvertiert (wie der Name schon sagt), aber hiermit haben wir mehr Möglichkeiten
-- Style-Parameter

-- Syntax etwas anders als beim CAST:
-- SELECT CONVERT(data_type[(length)], expression[, (style)])
-- 1: in welchen Datentyp soll konvertiert werden
-- 2: WAS soll konvertiert werden
-- 3: wie soll es dargestellt werden


SELECT CONVERT(float, '123.5') + 2
-- 125,5

-- funktioniert auch mit Datum:
SELECT CONVERT(varchar, SYSDATETIME())

-- wieder aufpassen auf Länge!
SELECT CONVERT(varchar(3), SYSDATETIME())
-- macht immer noch keinen Sinn ;)



-- Style-Parameter:
SELECT CONVERT(varchar, SYSDATETIME(), 104)



/*
	Date- und Time Styles in der Microsoft Dokumentation:
	
	https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles

*/


SELECT	  CONVERT(varchar, SYSDATETIME(), 104) AS DE
		, CONVERT(varchar, SYSDATETIME(), 101) AS US
		, CONVERT(varchar, SYSDATETIME(), 103) AS GB

-- ohne "century":
-- nicht empfohlen (potentielles Sicherheitsrisiko mit 20 - letzten zwei Stellen oder erste zwei Stellen?)
SELECT	  CONVERT(varchar, SYSDATETIME(), 4) AS DE
		, CONVERT(varchar, SYSDATETIME(), 1) AS US
		, CONVERT(varchar, SYSDATETIME(), 3) AS GB



SELECT	  CONVERT(varchar, HireDate, 104) AS DE
		, CONVERT(varchar, HireDate, 101) AS US
		, CONVERT(varchar, HireDate, 103) AS GB
FROM Employees



-- *************************** FORMAT ************************************
-- Ausgabedatentyp nvarchar

SELECT FORMAT(1234567890, '###-###/##-##')

SELECT FORMAT(431234567890, '+' + '##/### ## ## ###')

-- von rückwärts gezählt... wenn weniger/mehr Zeichen vorhanden sind...:

SELECT FORMAT(4312345678900987654, '+' + '##/### ## ## ###')

SELECT FORMAT(43123, '+' + '##/### ## ## ###')


-- funktioniert auch mit Datum:
SELECT FORMAT(SYSDATETIME(), 'dd.mm.yyyy')
-- Vorsicht!
-- wenn wir mm klein schreiben, glaubt FORMAT, dass wir die Minute meinen!
-- 17.41.2020


SELECT FORMAT(SYSDATETIME(), 'dd.MM.yyyy') -- MM groß schreiben
-- 17.09.2020

-- funktioniert NICHT bei FORMAT:
SELECT FORMAT('2020-09-17', 'dd.MM.yyyy')
-- Argument data type varchar is invalid for argument 1 of format function.
-- keine implizite Konvertierung


-- mit Info aus DB:
SELECT FORMAT(HireDate, 'dd.MM.yyyy')
FROM Employees


-- Culture-Parameter:

SELECT    FORMAT(SYSDATETIME(), 'd', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'd', 'en-us') AS US
		, FORMAT(SYSDATETIME(), 'd', 'en-gb') AS GB
		, FORMAT(SYSDATETIME(), 'd', 'sv') AS Schweden



SELECT    FORMAT(SYSDATETIME(), 'D', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'D', 'en-us') AS US
		, FORMAT(SYSDATETIME(), 'D', 'en-gb') AS GB
		, FORMAT(SYSDATETIME(), 'D', 'sv') AS Schweden

-- 'd' - steht für Datum in Zahlen: 17.09.2020
-- 'D' - steht für Datum als Text ausgeschrieben: Donnerstag, 17. September 2020


/*
	Supported Culture Parameters in der Microsoft Dokumentation:
	https://docs.microsoft.com/de-de/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes

*/

-- mit DB:

SELECT    FORMAT(HireDate, 'd', 'de-de') AS DE
		, FORMAT(HireDate, 'd', 'en-us') AS US
		, FORMAT(HireDate, 'd', 'en-gb') AS GB
		, FORMAT(HireDate, 'd', 'sv') AS Schweden
FROM Employees



-- Gib die Bestellnummer,
--     den Wunschtermin,
--      das Lieferdatum und
--     die Lieferverzögerung aus.
--Ergebnisse von Bestellungen, die noch nicht geliefert wurden, sollen nicht ausgegeben werden.
--Ordne das Ergebnis absteigend von der größten zur kleinsten Lieferverzögerung.
SELECT	  OrderID
		, RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
FROM Orders
WHERE ShippedDate IS NOT NULL
ORDER BY Lieferverzögerung DESC


SELECT	  OrderID
		, RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
FROM Orders
WHERE ShippedDate != NULL -- ACHTUNG!!! FALSCHES ERGEBNIS!!
ORDER BY Lieferverzögerung DESC
-- Hier bekommen wir keine Ergebnisse zurück - aber auch keine Fehlermeldung!
-- Der Fehler ist != NULL - wir müssen IS NOT NULL schreiben!!!


-- Datum in schönes Format bringen mit FORMAT:
SELECT	  OrderID
		, FORMAT(RequiredDate, 'd', 'de-de') AS RequiredDate
		, FORMAT(ShippedDate, 'd', 'de-de') AS ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
FROM Orders
WHERE ShippedDate IS NOT NULL
ORDER BY Lieferverzögerung DESC


-- oder mit CONVERT:
SELECT	  OrderID
		, CONVERT(varchar, RequiredDate, 104) AS RequiredDate
		, CONVERT(varchar, ShippedDate, 104) AS ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
FROM Orders
WHERE ShippedDate IS NOT NULL
ORDER BY Lieferverzögerung DESC



-- Gib die Mitarbeiternummer, den vollständigen Namen (in einer Spalte), die Anrede, das Geburtsdatum (ohne Zeitangabe) und die Telefonnummer aller Angestellten aus.
SELECT	  EmployeeID
		, Title
		, CONCAT(FirstName, ' ', LastName) AS FullName
		, FORMAT(BirthDate, 'dd.MM.yyyy') AS BirthDate
		, HomePhone
FROM Employees

-- oder:
SELECT	  EmployeeID
		, Title
		, CONCAT(FirstName, ' ', LastName) AS FullName
		, FORMAT(BirthDate, 'd', 'de-de') AS BirthDate
		, HomePhone
FROM Employees

-- oder:
SELECT	  EmployeeID
		, Title
		, CONCAT(FirstName, ' ', LastName) AS FullName
		, CONVERT(varchar, BirthDate, 104) AS BirthDate
		, HomePhone
FROM Employees