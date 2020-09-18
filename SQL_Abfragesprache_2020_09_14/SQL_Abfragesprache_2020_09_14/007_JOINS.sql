-- JOINS

-- Informationen aus mehreren Tabellen abfragen

-- INNER JOIN


-- LEFT JOIN
							-- OUTER JOIN
-- RIGHT JOIN




-- INNER JOIN
SELECT *
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID



SELECT    CompanyName
		, OrderID
--		, ...
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID



SELECT	  OrderID
		, Orders.CustomerID -- hier MÜSSEN wir dazuschreiben, aus welcher Tabelle
		, CompanyName
		, ContactName
		, Phone
--		, ...
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID



-- bei den anderen können und SOLLTEN wir dazuschreiben, aus welcher Tabelle sie kommen
SELECT	  Orders.OrderID
		, Orders.CustomerID -- hier MÜSSEN wir dazuschreiben, aus welcher Tabelle
		, Customers.CompanyName
		, Customers.ContactName
		, Customers.Phone
--		, ...
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID

-- Gleiches ein bisschen kürzer:
SELECT	  o.OrderID
		, o.CustomerID -- hier MÜSSEN wir dazuschreiben, aus welcher Tabelle
		, c.CompanyName
		, c.ContactName
		, c.Phone
--		, ...
FROM Customers AS c INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID


-- Gleiches ein bisschen kürzer:
SELECT	  o.OrderID
		, o.CustomerID -- hier MÜSSEN wir dazuschreiben, aus welcher Tabelle
		, c.CompanyName
		, c.ContactName
		, c.Phone
--		, ...
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID


-- auskommentieren: STRG + K, C (comment)
-- rückgängig: STRG + K, U (uncomment)



-- Gib die Namen der Anbieter (Supplier), die Sauce verkaufen, aus. (CompanyName, ProductName, Ansprechperson, Telefonnummer).
SELECT	  s.CompanyName
		, p.ProductName
		, s.ContactName
		, s.Phone
--		, s.SupplierID
FROM Products p INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE ProductName LIKE '%sauce%' -- OR ProductName LIKE '%soße%'



-- angenommen, es hat schon mehrere Beschwerden gegeben
-- Bestellungen mit der Nummer 10251, 10280, 10990, 11000
-- Welcher Angestellte hat denn die Bestellungen bearbeitet?
-- Bestellnummer und Vor- und Nachname von Angestellten

-- langsam:
-- wie bekomme ich genau die Informationen zu diesen Bestellnummern:
SELECT *
FROM Orders
WHERE OrderID IN(10251, 10280, 10990, 11000)

-- EmployeeID wer hat die bearbeitet?
SELECT EmployeeID
FROM Orders
WHERE OrderID IN(10251, 10280, 10990, 11000)

-- Information aus zwei Tabellen:
SELECT	  OrderID
		, o.EmployeeID
--		, FirstName
--		, LastName
		, CONCAT(FirstName, ' ', LastName) AS EmpName
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE OrderID IN(10251, 10280, 10990, 11000)




-- JOINEN von mehreren Tabellen

/*
	Syntax:

	SELECT    Spalte1
			, Spalte2
			, Spalte3
			, ...
	FROM Tabelle1 INNER JOIN Tabelle2 ON Tabelle1.SpalteX = Tabelle2.SpalteX
				  INNER JOIN Tabelle3 ON Tabelle2.SpalteY = Tabelle3.SpalteY

*/

-- Bsp.:
SELECT *
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
			  INNER JOIN Customers c ON c.CustomerID = o.CustomerID


-- welche Kunden waren an diesen Beschwerden beteiligt?
SELECT	  o.OrderID -- Orders-Tabelle
		, o.EmployeeID -- Orders-Tabelle
		, c.CustomerID -- Customers-Tabelle
		, c.CompanyName -- Customers-Tabelle
		, c.ContactName -- Customers-Tabelle
		, c.Phone -- Customers-Tabelle
		, CONCAT(e.FirstName, ' ', e.LastName) AS EmpName -- Employees -Tabelle
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
			  INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE OrderID IN(10251, 10280, 10990, 11000)



-- für Rechnung:
-- welche Kunden? welche Bestellung? wieviel? welche Produkte?

SELECT	  o.OrderID
		, o.CustomerID
		, c.CompanyName
		, od.ProductID
		, p.ProductName
		, od.Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.CustomerID



-- wie bekomme ich die Kunden, die noch nichts bestellt haben?


-- funktioniert NICHT mit Inner join!
-- damit bekommen wir nur die Kunden, die schon etwas bestellt haben
SELECT    CompanyName
		, OrderID
--		, ...
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE OrderID IS NULL


-- LEFT JOIN ?
-- damit bekommen wir auch die, die noch nichts bestellt haben:
SELECT    CompanyName
		, OrderID
--		, ...
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE OrderID IS NULL


-- RIGHT JOIN?
-- wieder nur die Kunden, die schon etwas bestellt haben
SELECT    CompanyName
		, OrderID
--		, ...
FROM Customers RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE OrderID IS NULL

-- könnte ich mit einem RIGHT JOIN wieder die Kunden bekommen, die noch nichts bestellt haben?
-- ja!
SELECT    CompanyName
		, OrderID
--		, ...
FROM Orders RIGHT JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE OrderID IS NULL