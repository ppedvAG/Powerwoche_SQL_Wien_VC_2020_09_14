-- CASE

SELECT    OrderID
		, Quantity
		, CASE
			WHEN Quantity > 10 THEN 'größer 10'
			WHEN Quantity = 10 THEN 'genau 10'

			ELSE 'unbekannt'
		  END -- AS MyText
FROM [Order Details]



SELECT *
FROM Customers


SELECT    CustomerID
		, Country
		, Region
FROM Customers
ORDER BY
		(CASE
			WHEN Region IS NULL THEN Country
			ELSE Region
		END)



-- Kunden:
-- wenn EU Mitglied, dann 'EU'
-- wenn kein EU Mitglied, dann 'nicht EU'
-- wenn UK, dann 'Brexit'
-- wenn nicht bekannt, 'Keine Ahnung'
SELECT CustomerID
		, Country
		, CASE
			WHEN Country = 'Portugal' THEN 'EU'
			WHEN Country = 'Germany' THEN 'EU'
			WHEN Country = 'Belgium' THEN 'EU'
			WHEN Country = 'UK' THEN 'Brexit'
			ELSE 'Keine Ahnung'
		END AS [Case]
FROM Customers
ORDER BY Country



SELECT CustomerID
		, Country
		, CASE
			WHEN Country IN('Portugal', 'Germany', 'Belgium') THEN 'EU'
			WHEN Country IN('Argentina', 'Brazil', 'Vanezuela') THEN 'nicht EU'
			WHEN Country = 'UK' THEN 'Brexit'
			ELSE 'Keine Ahnung'
		END AS [Case]
FROM Customers
ORDER BY Country
