-- MAXDOP
-- MAXimal Degree Of Parallelism

-- wieviele CPUs dürfen maximal für eine Abfrage verwendet werden

-- Daumen*Pi-Regel: nicht mehr als die Hälfte der verfügbaren CPUs
-- oder nicht mehr, als in einem Numa-Node drin sind, wenn mehr als 1 Numa-Node verwendet wird

-- Object Explorer -> Server (Rechtsklick) -> Properties -> Advanced -> Parallelism
-- Maximal Degree of Parallelism (0 Default = ALLE CPUs dürfen für P verwendet werden)
-- Cost Threshold (Kostenschwellwert): ab dem P verwendet werden darf (abhängig von SQL-$/ Estimated Subtree Cost)


SELECT *
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
			  INNER JOIN Customers c ON c.CustomerID = o.CustomerID


set statistics io, time on


SELECT	  o.OrderID -- Orders-Tabelle
		, o.EmployeeID -- Orders-Tabelle
		, c.CustomerID -- Customers-Tabelle
		, c.CompanyName -- Customers-Tabelle
		, c.ContactName -- Customers-Tabelle
		, c.Phone -- Customers-Tabelle
		, CONCAT(e.FirstName, ' ', e.LastName) AS EmpName -- Employees -Tabelle
FROM ku2 o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
			  INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE OrderID IN(10251, 10280, 10990, 11000)



