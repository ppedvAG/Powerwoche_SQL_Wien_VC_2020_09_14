-- HAVING




-- Rechnungssumme?
-- OrderID, Rechnungssumme


SELECT	  o.OrderID
		, UnitPrice*Quantity-Discount+Freight AS Rechnungsposten
FROM [Order Details] od INNER JOIN Orders o ON o.OrderID = od.OrderID
-- nicht ganz... das ist der Rechnungsposten


SELECT	  o.OrderID
		, SUM(UnitPrice*Quantity-Discount+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON o.OrderID = od.OrderID
GROUP BY o.OrderID
-- noch nicht ganz...
-- hier werden Frachtkosten pro Rechnungsposten hinzuaddiert (und Discount pro Rechnungsposten abgezogen)


-- Klammern setzen:
SELECT	  o.OrderID
		, (SUM(UnitPrice*Quantity)+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON o.OrderID = od.OrderID
GROUP BY o.OrderID, Freight


-- alle Bestellungen, wo die Rechnungssumme größer ist als 500
SELECT	  o.OrderID
		, (SUM(UnitPrice*Quantity)+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON o.OrderID = od.OrderID
-- WHERE (SUM(UnitPrice*Quantity)+Freight) > 500 -- FALSCH!
GROUP BY o.OrderID, Freight
HAVING (SUM(UnitPrice*Quantity)+Freight) > 500 -- RICHTIG
ORDER BY Rechnungssumme


-- Reihenfolge, in der ausgeführt wird:
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY




-- Wieviele Kunden gibts pro Land? Nur die, wo mehr als 5 Kunden pro Land vorhanden sind
-- Anzahl, Country
-- meiste Kunden zuerst
SELECT	  Country
		, COUNT(CustomerID) AS Anzahl
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5
ORDER BY Anzahl DESC



-- geht NICHT:
SELECT	  CustomerID
		, Country
		, COUNT(CustomerID) AS Anzahl
FROM Customers
GROUP BY CustomerID, Country
HAVING COUNT(CustomerID) > 5
ORDER BY Anzahl DESC
-- hier bekommen wir die Anzahl an CustomerIDs pro CustomerID...
-- ... also jeweils 1
-- ... die werden dann nicht angezeigt, wenn wir nur die ausgeben lassen, wo mehr als 5 sind


-- funktioniert NICHT mit WHERE!
SELECT	  Country
		, COUNT(CustomerID) AS Anzahl
FROM Customers
WHERE COUNT(CustomerID) > 5
GROUP BY Country
ORDER BY Anzahl DESC



-- alle Employees, die mehr als 70 Bestellungen bearbeitet haben
-- EmployeeID, vollständiger Name, Anzahl Bestellungen
SELECT	  COUNT(o.EmployeeID) AS Anzahl
		, CONCAT(e.FirstName, ' ', e.LastName) AS FullName
FROM Orders o INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName, e.LastName
HAVING COUNT(o.EmployeeID) > 70
ORDER BY Anzahl


-- Leverling, Peacock mehr als 100?
SELECT    e.EmployeeID
		, LastName
		, COUNT(OrderID) AS Bestellsumme
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE LastName IN('Leverling', 'Peacock')
GROUP BY e.EmployeeID, e.LastName
HAVING COUNT(OrderID) > 100
ORDER BY Bestellsumme


-- Angestellten mit ID NR. 3 und 4, wenn Bestellungen > 100
SELECT    e.EmployeeID
		, LastName
		, COUNT(OrderID) AS Bestellsumme
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE e.EmployeeID IN(3, 4)
GROUP BY e.EmployeeID, e.LastName
HAVING COUNT(OrderID) > 100
ORDER BY Bestellsumme
