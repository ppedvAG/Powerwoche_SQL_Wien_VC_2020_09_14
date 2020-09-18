-- Procedures

CREATE PROC pDemo
AS
SELECT TOP 1 Freight FROM Orders ORDER BY Freight
SELECT TOP 1 Freight FROM Orders ORDER BY Freight DESC
SELECT Country FROM Customers WHERE Region IS NOT NULL
GO

EXEC pDemo


CREATE PROC pCustomersCities @City varchar(30)
AS
SELECT * FROM Customers WHERE City = @City
GO

EXEC pCustomersCities @City = 'Buenos Aires'



CREATE PROC pCustomersCountryCity @Country varchar(30), @City varchar(30)
AS
SELECT * FROM Customers WHERE Country = @Country AND City = @City
GO


EXEC pCustomersCountryCity @Country = 'Germany', @City = 'Berlin'
