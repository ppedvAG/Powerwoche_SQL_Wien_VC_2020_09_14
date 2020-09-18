-- MAXDOP
-- MAXimal Degree Of Parallelism

-- wieviele CPUs d�rfen maximal f�r eine Abfrage verwendet werden

-- Daumen*Pi-Regel: nicht mehr als die H�lfte der verf�gbaren CPUs
-- oder nicht mehr, als in einem Numa-Node drin sind, wenn mehr als 1 Numa-Node verwendet wird

-- Object Explorer -> Server (Rechtsklick) -> Properties -> Advanced -> Parallelism
-- Maximal Degree of Parallelism (0 Default = ALLE CPUs d�rfen f�r P verwendet werden)
-- Cost Threshold (Kostenschwellwert): ab dem P verwendet werden darf (abh�ngig von SQL-$/ Estimated Subtree Cost)


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



