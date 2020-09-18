-- Wildcards


/*
	%......... steht für beliebig viele unbekannte Zeichen (0 - ?)
	[]........ steht für genau ein Zeichen aus diesem Wertebereich
	^......... steht innerhalb der eckigen Klammern für NICHT
	_......... (Unterstrich) steht für genau 1 unbekanntes Zeichen
	|......... (pipe) steht innerhalb der eckigen Klammern für "oder" 

*/
-- der Kunde, dessen ID mit ALF beginnt
SELECT *
FROM Customers
WHERE CustomerID LIKE 'ALF%'

-- mögliche Treffer:
-- ALF
-- ALFKI
-- ALFXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- ALF5754543


-- alle Kunden, die mit A beginnen:
SELECT *
FROM Customers
WHERE CustomerID LIKE 'A%'


-- alle, die mit MI enden:
SELECT *
FROM Customers
WHERE CustomerID LIKE '%MI'


-- irgendwo im Namen kommt "kist" vor:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%kist%'


-- alle Kunden, wo irgendwo im Firmennamen ein "D" vorkommt
SELECT *
FROM Customers
WHERE CompanyName LIKE '%d%'

-- D
-- Dx
-- xD
-- xDx
-- xxxxxxxxxDxxxxxxxx
-- xdxdxdxdxd


-- Wertebereiche abfragen

-- eckige Klammern bisher:
-- bisher bei [vollständiger Name] als Spaltenüberschrift
-- [Tabellenname]
-- [Spaltenname]

-- beim LIKE: eckige Klammern als Wildcard für Wertebereich:

-- alle Kunden, die mit a, b oder c beginnen:
SELECT *
FROM Customers
WHERE CustomerID LIKE 'a%' OR CustomerID LIKE 'b%' OR CustomerID LIKE 'c%'

-- oder kürzer:
SELECT *
FROM Customers
WHERE CustomerID LIKE '[a-c]%'

-- a
-- b
-- c
-- ax
-- bx
-- cx
-- abcx

-- würde auch funktionieren:
--SELECT *
--FROM Customers
--WHERE CustomerID LIKE '[abc]%'


-- alle, die mit a oder c beginnen
SELECT *
FROM Customers
WHERE CustomerID LIKE 'a%' OR CustomerID LIKE 'c%'

-- oder:
SELECT *
FROM Customers
WHERE CustomerID LIKE '[ac]%'


-- alle, die mit abc beginnen?
SELECT *
FROM Customers
WHERE CustomerID LIKE 'abc%'

-- gibt keinen Kunden, dessen CustomerID mit ABC beginnt


-- Sonderzeichen suchen (wenn Sonderzeichen schon eine andere Bedeutung hat)
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[%]%'

-- xxxx%xxxx
-- %xxx
-- xxx%


-- ESCAPE Character
SELECT *
FROM Customers
WHERE CompanyName LIKE '%!%%' ESCAPE '!'



-- alle mit Hochkomma im Namen:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%''%' -- ACHTUNG: '', nicht ' (Ausnahme)


-- alle, die mit a beginnen und mit e enden:
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%' AND CompanyName LIKE '%e'

-- oder kürzer:
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%e'


-- **************************** NOT ********************************************
-- die, die NICHT mit a-c beginnen
SELECT *
FROM Customers
WHERE CustomerID LIKE '[^a-c]%'
-- auch hier wieder: wenn möglich positiv formulieren, und nicht "NICHT" verwenden
-- idealerweise positiv formulieren:
SELECT *
FROM Customers
WHERE CustomerID LIKE '[d-z]%'


-- ************************** genau 1 unbekanntes Zeichen suchen *****************

SELECT *
FROM Customers
WHERE CustomerID LIKE 'ALFK_'


SELECT Phone
FROM Customers
WHERE Phone LIKE '(5) 555-472_'


-- alle, deren Firmenname mit a-c oder e-g enden:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c]' OR CompanyName LIKE '%[e-g]'


-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c | e-g]' -- | heißt hier "oder"


-- oder:
--SELECT *
--FROM Customers
--WHERE CompanyName LIKE '%[abcefg]'


-- Gib alle Produkte aus, deren Name mit „coffee“ endet.
SELECT *
FROM Products
WHERE ProductName LIKE '%coffee'


-- Gib alle Produkte aus, deren Name mit 'L' beginnt.
SELECT *
FROM Products
WHERE ProductName LIKE 'L%'

-- Gib alle Produkte aus, die ein 'ost' im Namen haben.
SELECT *
FROM Products
WHERE ProductName LIKE '%ost%'



-- Gib alle Produkte aus, deren Name mit D-L beginnt und mit a, b, c, d oder m, n, o endet.
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%[a-d | m-o]'



SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND (ProductName LIKE '%[a-d]' OR ProductName LIKE '%[m-o]')



--Gib alle Produkte aus, die vom Anbieter (SupplierID) 5, 10 oder 15 stammen, von denen mehr als 10 Stück vorrätig sind und deren Stückpreis unter 100 liegt.
--Ordne das Ergebnis absteigend vom höchsten zum niedrigsten Stückpreis.
SELECT *
FROM Products
WHERE SupplierID IN(5, 10, 15) AND UnitsInStock > 10 AND UnitPrice < 100
ORDER BY UnitPrice DESC




-- ALF5I
-- wie finde ich die falschen Einträge?

SELECT    CustomerID
		, PATINDEX('%[0-9]%', CustomerID) AS Prüfspalte
FROM Customers
WHERE PATINDEX('%[0-9]%', CustomerID) > 0


SELECT *
FROM Customers
WHERE CustomerID NOT LIKE '[a-z][a-z][a-z][a-z][a-z]'


-- alle Kunden, die mit d, e oder f beginnen, der letzte Buchstabe ist ein L und der DRITTLETZTE ist ein d
SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-f]%' AND CompanyName LIKE '%d_l'

-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-f]%d_l'


/*
	mögliche Ergebnisse:

	edel
	edxl
	fidel
	ddxl
	dxxxxxxxxxxxxxxxxdxl

	Ernst Handel (in Northwind-DB)
	e........d.l


*/



