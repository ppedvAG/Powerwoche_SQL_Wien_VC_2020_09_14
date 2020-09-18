-- Tabellenabfragen
-- SELECT auf Tabellen
-- immer überprüfen, welche Datenbank verwendet wird!

USE Northwind


SELECT	  CompanyName
FROM Customers


SELECT	  CompanyName
		, CustomerID
		, ContactName
		, Phone
FROM Customers



SELECT	  CompanyName
		, CustomerID
		, ContactName
		, Phone
		, 100
		, 'Testtext'
FROM Customers


SELECT Freight * 100 AS [hundertfache Frachtkosten]
FROM Orders


SELECT * -- alle Spalten dieser Tabelle
FROM Customers


SELECT	  CustomerID AS Kundennummer
		, CompanyName AS Firmenname
FROM Customers


-- AS darf theoretisch weggelassen werden (nicht empfohlen)
SELECT	  CustomerID Kundennummer
		, CompanyName Firmenname
FROM Customers


-- Gib KundenID, Firmenname, Kontaktperson und Telefonnummer aller Kunden aus.
SELECT	  CustomerID
		, CompanyName
		, ContactName
		, Phone
FROM Customers



-- Gib die ProduktID, den Produktnamen und den Stückpreis aus.
SELECT	  ProductID
		, ProductName
		, UnitPrice
FROM Products



-- Gib die Nettofrachtkosten, Bruttofrachtkosten und die Mehrwertsteuer aus (Berechnung).

SELECT	  Freight AS Nettofrachtkosten
		, Freight*1.19 AS Bruttofrachtkosten
		, Freight*0.19 AS MwSt
FROM Orders

