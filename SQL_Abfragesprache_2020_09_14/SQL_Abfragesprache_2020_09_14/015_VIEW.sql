-- VIEWS (Sichten)
USE Northwind


-- alle deutschsprachigen Kunden


CREATE VIEW vCustomersDE
AS
SELECT	CustomerID
		, CompanyName
		, ContactName
		, Phone
--		, ...
FROM Customers
WHERE Country IN('Germany', 'Austria', 'Switzerland')
GO


SELECT CompanyName, Phone
FROM vCustomersDE




CREATE VIEW vCustomersFreight
AS
SELECT    o.CustomerID
		, c.CompanyName
		, c.City
		, c.Country
		, o.Freight
--		, ...
FROM Customers C INNER JOIN Orders o ON c.CustomerID = o.CustomerID



