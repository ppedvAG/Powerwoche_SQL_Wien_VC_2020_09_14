-- Datenbankerstellung

-- ER-Diagramm: Hilft bei der Kommunikation zwischen Kunde und Datenbanklern ;)
-- Unterschiedliche Notationsformen (z.B. Chen, Min-Max, Crow's Foot,...)
-- entity (wird dann zur Tabelle), relation (kann in machen F�llen zu einer Tabelle werden - n:n), attributes (werden zu Spalten)



-- Normalformen
-- 1. NF: "atomar" (1 Eintrag pro Feld)
-- also NICHT "Name", sonder "FirstName", "LastName"

-- Name               ,     Adresse                 , Bestellung, Produkt,... 
-- FirstName, LastName,     Stra�e, Hausnr,.......  , .....

-- 2. NF: 1.NF muss erf�llt sein und alle m�ssen von 1 Schl�ssel abh�ngig sein
-- Kundentabelle                             -- Bestellungentabelle
-- KundenID                                  -- OrderID
-- FirstName                                 -- Bestelldatum
-- LastName                                  -- ...
-- Stra�e
-- HausNr
-- Ort
-- Plz
-- .....


-- 3. NF: 1. und 2.NF m�ssen erf�llt sein und es d�rfen keine transitiven Abh�ngigkeiten bestehen
-- (Nicht-Schl�sselfelder d�rfen nicht voneinander abh�ngig sein)
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

	--> 7 Mio Datens�tze durchsuchen f�r Ergebnis
	-- Redundanzfreier Ansatz: Joins �ber alle drei Tabellen
	-- wir m�ssen uns 7 Mio Datens�tze ansehen, um zum Ergebnis zu kommen

	-- h�tten wir eine Spalte Bestellsumme in den Bestellungen, haben wir zwar Redundanz und 1 Spalte mehr, ABER
	-- wir m�ssen nur noch 3 Mio Datens�tze durchsuchen

*/


-- welche Datentypen verwenden wir?


--SELECT Country
--FROM Customers


-- DROP DATABASE Test
-- nur zum �ben - ansonsten Achtung: Falls Berechtigung vorhanden, l�scht das DIE GESAMTE DB INKLUSIVE INHALT!
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
-- wenn nichts angegeben, starten wir bei 1 und z�hlen jeweils 1 hoch
-- wir k�nnen das auch vorgeben: IDENTITY(100, 5) started bei 100 und z�hlt jeweils 5 hoch


-- nicht ganz so sch�n:
INSERT INTO Produkte
VALUES ('Spaghetti', '1.99')

SELECT *
FROM Produkte


INSERT INTO Produkte (Preis, ProduktName) -- Reihenfolge!
VALUES (1.89, 'Penne'), -- Reihenfolge genauso wie oben, dann passt das
	   (4.99, 'Tiramisu'),
	   (5.49, 'Profiterols')


-- Werte ver�ndern mit UPDATE
-- immer mit WHERE einschr�nken!! Sonst wird der Preis f�r ALLE gesetzt!
-- idealerweise etwas nehmen, womit man die gew�nschte Auswahl eindeutig identifizieren kann (z.B. ID)

UPDATE Produkte
SET Preis = 5.39
WHERE ProduktID = 4

-- DROP TABLE Produkte
-- l�scht komplette Tabelle inklusive Inhalt


-- DELETE FROM tablename = Inhalt der Tabelle l�schen (Tabelle selbst ist noch da)
-- DELETE IMMER mit WHERE einschr�nken!! sons kompletter Inhalt weg

DELETE FROM Produkte
WHERE ProduktID = 6


SELECT *
FROM Produkte



-- Tabelle selbst ver�ndern mit ALTER
-- ALTER TABLE tablename

ALTER TABLE Produkte
ALTER COLUMN ProduktName nvarchar(50)



-- sp_help Produkte

-- neue Spalte hinzuf�gen
ALTER TABLE Produkte
ADD Email nvarchar(50)


-- uups, Fehler passiert, falsche Tabelle
-- Email soll nicht in die Produkte
ALTER TABLE Produkte
DROP COLUMN Email
-- auch dieses DROP l�scht die gesamte Spalte inklusive Inhalt


-- Schl�ssel
-- Primary Key (Hauptschl�ssel)
		-- von dem sind alle anderen Eintr�ge abh�ngig
		-- wenn ich meine CustomerID kenne, kann ich nachschauen, wo der Kunde wohnt, wie er hei�t --> Rechnungsadresse, etc.
-- Foreigen Key (Fremdschl�ssel)
		-- damit stellen wir eine Verbindung zu einer anderen Tabelle her
		-- CustomerID in Orders ist ein Foreign Key
		-- wenn ich die CustomerID kenne, wei� ich, welcher Kunde diese Bestellung get�tigt hat
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
ADD CONSTRAINT PK_Orders3 PRIMARY KEY (OrderID) -- Constraint �ber ALTER TABLE hinzuf�gen


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






