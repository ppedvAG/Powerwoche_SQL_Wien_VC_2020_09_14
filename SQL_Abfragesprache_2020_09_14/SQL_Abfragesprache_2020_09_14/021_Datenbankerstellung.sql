-- Datenbankerstellung

-- ER-Diagramm: Hilft bei der Kommunikation zwischen Kunde und Datenbanklern ;)
-- Unterschiedliche Notationsformen (z.B. Chen, Min-Max, Crow's Foot,...)
-- entity (wird dann zur Tabelle), relation (kann in machen Fällen zu einer Tabelle werden - n:n), attributes (werden zu Spalten)



-- Normalformen
-- 1. NF: "atomar" (1 Eintrag pro Feld)
-- also NICHT "Name", sonder "FirstName", "LastName"

-- Name               ,     Adresse                 , Bestellung, Produkt,... 
-- FirstName, LastName,     Straße, Hausnr,.......  , .....

-- 2. NF: 1.NF muss erfüllt sein und alle müssen von 1 Schlüssel abhängig sein
-- Kundentabelle                             -- Bestellungentabelle
-- KundenID                                  -- OrderID
-- FirstName                                 -- Bestelldatum
-- LastName                                  -- ...
-- Straße
-- HausNr
-- Ort
-- Plz
-- .....


-- 3. NF: 1. und 2.NF müssen erfüllt sein und es dürfen keine transitiven Abhängigkeiten bestehen
-- (Nicht-Schlüsselfelder dürfen nicht voneinander abhängig sein)
-- Kundentabelle         --> Ortstabelle
-- KundenID                  -- Plz
-- FirstName                 -- Ort
-- ...
-- Ort
-- Plz

-- SINN?? Von Fall zu Fall entscheiden!

/*
	-- Kundenumsatz gesucht:

	Kunde:        1Mio - durchschnittlich 2 Bestellungen
	Bestellungen: 2Mio - durchschnittlich 2 Artikel pro Bestellung
	Positionen:   4Mio Bestelldetails

	--> 7 Mio Datensätze durchsuchen für Ergebnis
	-- Redundanzfreier Ansatz: Joins über alle drei Tabellen
	-- wir müssen uns 7 Mio Datensätze ansehen, um zum Ergebnis zu kommen

	-- hätten wir eine Spalte Bestellsumme in den Bestellungen, haben wir zwar Redundanz und 1 Spalte mehr, ABER
	-- wir müssen nur noch 3 Mio Datensätze durchsuchen

*/


-- welche Datentypen verwenden wir?


--SELECT Country
--FROM Customers


-- DROP DATABASE Test
-- nur zum Üben - ansonsten Achtung: Falls Berechtigung vorhanden, löscht das DIE GESAMTE DB INKLUSIVE INHALT!
CREATE DATABASE Test


USE Test


-- Tabellen erstellen
-- CREATE TABLE tablename (columname datatype)

CREATE TABLE Produkte (
							ProduktID smallint IDENTITY(1, 1) PRIMARY KEY,
							ProduktName varchar(50) NOT NULL,
							Preis money,
--							... UNIQUE, -- darf nur 1x vorkommen
--							...,
					  )

-- IDENTITY: generiert ID
-- wenn nichts angegeben, starten wir bei 1 und zählen jeweils 1 hoch
-- wir können das auch vorgeben: IDENTITY(100, 5) started bei 100 und zählt jeweils 5 hoch


-- nicht ganz so schön:
INSERT INTO Produkte
VALUES ('Spaghetti', '1.99')

SELECT *
FROM Produkte


INSERT INTO Produkte (Preis, ProduktName) -- Reihenfolge!
VALUES (1.89, 'Penne'), -- Reihenfolge genauso wie oben, dann passt das
	   (4.99, 'Tiramisu'),
	   (5.49, 'Profiterols')


-- Werte verändern mit UPDATE
-- immer mit WHERE einschränken!! Sonst wird der Preis für ALLE gesetzt!
-- idealerweise etwas nehmen, womit man die gewünschte Auswahl eindeutig identifizieren kann (z.B. ID)

UPDATE Produkte
SET Preis = 5.39
WHERE ProduktID = 4

-- DROP TABLE Produkte
-- löscht komplette Tabelle inklusive Inhalt


-- DELETE FROM tablename = Inhalt der Tabelle löschen (Tabelle selbst ist noch da)
-- DELETE IMMER mit WHERE einschränken!! sons kompletter Inhalt weg

DELETE FROM Produkte
WHERE ProduktID = 6


SELECT *
FROM Produkte



-- Tabelle selbst verändern mit ALTER
-- ALTER TABLE tablename

ALTER TABLE Produkte
ALTER COLUMN ProduktName nvarchar(50)



-- sp_help Produkte

-- neue Spalte hinzufügen
ALTER TABLE Produkte
ADD Email nvarchar(50)


-- uups, Fehler passiert, falsche Tabelle
-- Email soll nicht in die Produkte
ALTER TABLE Produkte
DROP COLUMN Email
-- auch dieses DROP löscht die gesamte Spalte inklusive Inhalt


-- Schlüssel
-- Primary Key (Hauptschlüssel)
		-- von dem sind alle anderen Einträge abhängig
		-- wenn ich meine CustomerID kenne, kann ich nachschauen, wo der Kunde wohnt, wie er heißt --> Rechnungsadresse, etc.
-- Foreigen Key (Fremdschlüssel)
		-- damit stellen wir eine Verbindung zu einer anderen Tabelle her
		-- CustomerID in Orders ist ein Foreign Key
		-- wenn ich die CustomerID kenne, weiß ich, welcher Kunde diese Bestellung getätigt hat
		-- Schnittstelle zu anderen Tabellen


-- Variante 1
CREATE TABLE Orders(
						 OrderID int identity PRIMARY KEY,  -- hier gleich dazuschreiben
						 CustomerID int,
						 OrderDate date,
						 ShipVia int
	--					 ...
	--					 ...
						)


-- Variante 2:
CREATE TABLE Orders2(
						 OrderID int identity,
						 CustomerID int,
						 OrderDate date,
						 ShipVia int
	--					 ...
	--					 ...
						CONSTRAINT PK_Orders2 PRIMARY KEY (OrderID) -- Constraint im Create
					)


-- Variante 3:

CREATE TABLE Orders3(
						 OrderID int identity,
						 CustomerID int,
						 OrderDate date,
						 ShipVia int
	--					 ...
	--					 ...
					)

ALTER TABLE Orders3
ADD CONSTRAINT PK_Orders3 PRIMARY KEY (OrderID) -- Constraint über ALTER TABLE hinzufügen


-- Foreign Keys:


-- Variante 1:
CREATE TABLE Orders4(
						 OrderID int identity,
						 CustomerID int FOREIGN KEY REFERENCES Customers4(CustomerID),
						 OrderDate date,
						 ShipVia int
	--					 ...
	--					 ...
					)

-- Das funktioniert nur dann, wenn es die Tabelle Customers4 und die Spalte CustomerID darin schon gibt!!!!


CREATE TABLE Customers4(
							CustomerID int identity PRIMARY KEY,
							CompanyName nvarchar(30),
--							...
--							...

						)


-- Variante 2:
CREATE TABLE Orders5(
						 OrderID int identity,
						 CustomerID int,
						 OrderDate date,
						 ShipVia int
	--					 ...
	--					 ...
			CONSTRAINT FK_Orders2 FOREIGN KEY (CustomerID) REFERENCES Customers5(CustomerID)
					)


-- Variante 3:
CREATE TABLE Orders6(
						 OrderID int identity PRIMARY KEY,
						 CustomerID int,
						 OrderDate date,
						 ShipVia int
	--					 ...
	--					 ...
					)

CREATE TABLE Customers6(
							CustomerID int IDENTITY PRIMARY KEY,
							CompanyName nvarchar(30),
--							...
--							...

						)

ALTER TABLE Orders6
ADD CONSTRAINT FK_Orders6_Customers6 FOREIGN KEY (CustomerID) REFERENCES Customers6(CustomerID)






