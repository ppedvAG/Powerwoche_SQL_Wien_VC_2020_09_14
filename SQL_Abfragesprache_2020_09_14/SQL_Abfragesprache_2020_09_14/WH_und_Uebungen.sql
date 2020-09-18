-- Wiederholung und Übungen

SELECT 'Testtext', 100, 100*3



SELECT    'Testtext' AS MeinText
		, 100 AS Zahl 
		, 100*3 Berechnung -- AS darf auch weggelassen werden (nicht empfohlen; dann sehen wir auf den ersten Blick, dass hier ein ALIAS vergeben wurde)


USE Northwind


-- * sollten wir nicht verwenden - Tabellen können sich ändern!
SELECT *
FROM Customers


SELECT	  CustomerID
		, CompanyName
--		, ...
FROM Customers


-- Alle Angestellten
-- ID, Name, Phone
-- Vor- und Nachname als vollständiger Name in einer Spalte
SELECT	  EmployeeID
		, FirstName
		, LastName
		, HomePhone
FROM Employees

-- wie bekommen wir Name in einer Spalte?
SELECT CONCAT('James', ' ', 'Bond')

SELECT CONCAT(FirstName, ' ', LastName)
FROM Employees


SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS EmpName
		, HomePhone
FROM Employees



-- nur die Angestellten, die in UK wohnen?
SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS EmpName
		, HomePhone
FROM Employees
WHERE Country = 'UK'



-- Gib alle Kunden (Firmenname) aus Brasilien und deren Frachtkosten aus.
-- Ordne die Ausgabe aufsteigend nach Frachtkosten.
SELECT	  o.OrderID
		, o.CustomerID
		, c.CompanyName
		, o.Freight
--		, ...
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'Brazil'
ORDER BY Freight -- ASC


---- Welche Kunden haben Chai Tee gekauft und wieviel?
--(OrderID, CustomerID, CompanyName, ProductName, Quantity)

SELECT	  o.OrderID
		, o.CustomerID
		, c.CompanyName
		, p.ProductName
		, od.Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE p.ProductName LIKE '%chai%'




-- Profiübung
-- Wer ist der Chef von wem?
--Ausgabe:
--Name Angestellter, ID Angestellter, Name Chef, ID vom Chef
--SELECT e.EmployeeID
--		, e.FirstName
--		, e.LastName
--		, e.ReportsTo
--		, e3.FirstName
--		, e3.LastName
--FROM Employees e LEFT JOIN Employees e2 ON e2.EmployeeID = e.EmployeeID
--				 LEFT JOIN Employees e3 ON e3.EmployeeID = e2.ReportsTo


-- alle, auch die, bei denen kein Chef eingetragen ist
SELECT     CONCAT(emp.FirstName, ' ', emp.LastName)    AS Angestellter
        , emp.EmployeeID                    AS AngestellterID
        , CONCAT(chef.FirstName, ' ', chef.LastName)    AS Chef
        , chef.EmployeeID                    AS ChefID
FROM Employees AS emp LEFT JOIN Employees AS chef  ON emp.ReportsTo = chef.EmployeeID


-- nur die, bei denen auch ein ReportsTo eingetragen ist (die einen Chef haben)
SELECT     CONCAT(emp.FirstName, ' ', emp.LastName)    AS Angestellter
        , emp.EmployeeID                    AS AngestellterID
        , CONCAT(chef.FirstName, ' ', chef.LastName)    AS Chef
        , chef.EmployeeID                    AS ChefID
FROM Employees AS emp INNER JOIN Employees AS chef  ON emp.ReportsTo = chef.EmployeeID




--Suche alle Bestellungen, bei denen Bier verkauft wurde. Welcher Kunde? Wieviel? Welches Bier?
--Tipp: Der Produktname kann „Bier“ oder „Lager“ enthalten oder mit „Ale“ enden.
--Nach Menge und Kundenname geordnet:
--	Menge absteigend (größte zuerst), 	Kundenname aufsteigend (A-Z)
SELECT	  o.OrderID
		, o.CustomerID
		, c.CompanyName
		, p.ProductName
		, od.Quantity
--		, ...
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE p.ProductName LIKE '%bier%' OR p.ProductName LIKE '%lager%' OR p.ProductName LIKE '%ale'
ORDER BY od.Quantity DESC, c.CompanyName -- ASC



-- Welcher Angestellte hat wem wieviel Chai Tee verkauft?
SELECT	  o.OrderID
		, o.CustomerID
		, c.CompanyName
		, CONCAT(e.FirstName, ' ', e.LastName) AS EmpName
		, p.ProductName
		, od.Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE p.ProductName LIKE '%chai%'




-- Profiübung 2 (Fahrgemeinschaft):
-- Geben Sie alle Kunden aus, die in der gleichen Stadt wohnen, wie ein anderer Kunde (nicht sie selbst).
--Ausgabe:
--Customer1, City1, Customer2, City2
SELECT	  c1.CompanyName
		, c1.City
		, c2.CompanyName
		, c2.City
FROM Customers c1 INNER JOIN Customers c2 ON c1.City = c2.City
WHERE c1.CustomerID != c2.CustomerID
ORDER BY c1.City



SELECT	  c1.City
		, c1.CompanyName AS Kunde1
		, c2.CompanyName AS Kunde2
FROM Customers c1 INNER JOIN Customers c2 ON c1.City = c2.City
WHERE c1.CustomerID != c2.CustomerID
ORDER BY c1.City


-- Summe der Frachtkosten pro Kunde
SELECT SUM(Freight)
	, CustomerID
FROM Orders
GROUP BY CustomerID

