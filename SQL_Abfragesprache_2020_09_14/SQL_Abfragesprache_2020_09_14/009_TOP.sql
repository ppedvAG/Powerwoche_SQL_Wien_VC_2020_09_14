-- TOP 
-- ORDER BY zwingend notwendig!
-- ORDER BY stellt sicher, dass die Daten in einer für uns nachvollziehbaren Reihenfolge ausgegeben werden; was ist die erste Zeile? Abhängig von ORDER BY!!




-- einschränken, wieviele Spalten ausgegeben werden
-- im SELECT: welche Spalten wollen wir anzeigen
SELECT CustomerID, CompanyName
FROM Customers


-- auf z.B. bestimmte Kundengruppen einschränken im WHERE
-- nur die brasilianischen Kunden
SELECT CustomerID, CompanyName
FROM Customers
WHERE Country = 'Brazil'



-- Anzahl der ausgegebenen Zeilen einschränken
-- mit TOP
SELECT TOP 1 *
FROM Customers

-- aber WAS ist die erste Zeile??? --> ORDER BY


SELECT TOP 1 *
FROM Customers
ORDER BY Country
-- anderes Ergebnis!



-- bestimmte Spalten auswählen trotz TOP-Befehl!
SELECT TOP 1 
			  CustomerID
			, CompanyName
			, Country
FROM Customers
ORDER BY Country


-- mehrere Zeilen ausgeben:
SELECT TOP 10 
			  CustomerID
			, CompanyName
			, Country
FROM Customers
ORDER BY Country
-- gibt die ersten 10 (geordnet nach Land) aus



-- darf selbstverständlich auch mit einem WHERE kombiniert werden:
SELECT TOP 10 
			  CustomerID
			, CompanyName
			, Country
FROM Customers
WHERE Country LIKE '[g-x]%'
ORDER BY Country



-- geht auch mit Prozent... erste 7% ausgeben:
SELECT TOP 7 PERCENT 
			    OrderID
			  , CustomerID
			  , Freight
			  , ShipCountry
FROM Orders
-- WHERE ShipCountry LIKE '[g-x]%'
ORDER BY ShipCountry


-- wie bekommen wir die letzten 5 Einträge?
SELECT TOP 5
			  CustomerID
			, CompanyName
			, Country
FROM Customers
ORDER BY Country DESC -- Sortierreihenfolge umkehren! Vom größten zum kleinsten Wert ordnen



-- ProductID, ProductName, UnitPrice
-- welches ist unser teuerstes Produkt?
SELECT TOP 1 ProductID
		   , ProductName
		   , UnitPrice
FROM Products
ORDER BY UnitPrice DESC


-- Suche die Top 10% der Produkte mit den größten Verkaufsmengen (ProductName, Quantity).
SELECT TOP 10 PERCENT
		  od.OrderID
		, p.ProductName
		, od.Quantity
FROM [Order Details] od INNER JOIN Products p ON od.ProductID = p.ProductID
ORDER BY Quantity DESC
-- 216


-- gleiche Angabe, aber auch die mit der gleichen Quantity wie auf dem letzten Platz
SELECT TOP 10 PERCENT WITH TIES
		  od.OrderID
		, p.ProductName
		, od.Quantity
FROM [Order Details] od INNER JOIN Products p ON od.ProductID = p.ProductID
ORDER BY Quantity DESC
-- 234