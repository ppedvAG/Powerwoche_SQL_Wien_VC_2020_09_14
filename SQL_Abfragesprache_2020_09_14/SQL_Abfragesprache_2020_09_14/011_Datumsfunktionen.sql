-- Datumsfunktionen


-- gängige Datentypen
-- datetime (auf mehrere Millisekunden genau)
-- datetime2 (auf ~ 100 Nanosekunden genau)
-- date
-- time


/*
	Datumsintervalle:
		year, yyyy, yy = Jahr
		quarter, qq, q = Quartal
		month, MM, M = Monat
		week, ww, wk = Woche
		day, dd, d = Tag
		hour, hh = Stunde
		minute, mi, n = Minute
		second, ss, s = Sekunde
		millisecond, ms = Millisekunde
		nanosecond, ns = Nanosekunde

		weekday, dw, w = Wochentag (dw = day of the week)
		dayofyear, dy, y = Tag des Jahres

*/



-- ******************** Datum abfragen ************************************
-- datetime (ms)
SELECT GETDATE()

-- datetime2 (ns)
SELECT SYSDATETIME()


-- **************************** DATEADD ***********************************
-- Datumsberechnungen: etwas zum Datum hinzuzählen/wegzählen


-- Format: Schreibweise systemabhängig!

SELECT DATEADD(hh, 10, '2020-09-16')
-- wenn keine Uhrzeit angegeben wird, wird von 0:00 Uhr ausgegangen!

-- Stunden, Minuten usw. können optional angegeben werden
SELECT DATEADD(hh, 10, '2020-09-16 15:29')
-- 2020-09-17 01:29:00.000


-- mit dem aktuellen Datum:
SELECT DATEADD(hh, 10, GETDATE())
-- 2020-09-17 01:32:24.963
-- oder:
SELECT DATEADD(hh, 10, SYSDATETIME())


-- wir dürfen mit negativem Vorzeichen arbeiten:
-- 10 Stunden vom aktuellen Datum und der aktuellen Uhrzeit abziehen:
SELECT DATEADD(hh, -10, SYSDATETIME())
-- 2020-09-16 05:44:18.9410910


-- **************************** DATEDIFF ******************************
-- Differenz zwischen zwei Daten bilden

SELECT DATEDIFF(dd, '2020-09-14', '2020-09-16')

-- in wie vielen Tagen ist der nächste Feiertag?
SELECT DATEDIFF(dd, '2020-09-16', '2020-09-20')
-- 4


SELECT DATEDIFF(dd, '2020-09-20', '2020-09-16')
-- -4 (negatives Vorzeichen)


-- auch hier können wir mit dem aktuellen Datum arbeiten:
SELECT DATEDIFF(dd, GETDATE(), '2020-09-20')


-- *************************** DATEPART ******************************
-- Datumsteil ausgeben:

SELECT DATEPART(dd, '2020-09-16') -- 16
SELECT DATEPART(dd, GETDATE()) -- 16
SELECT DATEPART(MM, GETDATE()) -- 9
SELECT DATEPART(yyyy, GETDATE()) -- 2020


-- ************************* DATENAME *********************************
-- bei Datename machen nur die Sinn, die wir als Text ausschreiben können
-- dw (Wochentag) und month (Monat)


-- bringt nix:
SELECT DATENAME(dd, '2020-09-16') -- 16


SELECT DATENAME(dw, '2020-09-16') -- Wednesday
SELECT DATENAME(month, '2020-09-16') -- September


-- Welches Datum haben wir in 38 Tagen?
SELECT DATEADD(dd, 38, GETDATE())
SELECT DATEADD(dd, 38, '2020-09-16')


-- Welcher Wochentag war Dein Geburtstag?
SELECT DATENAME(dw, '1981-04-22') -- Wednesday


-- Vor wie vielen Jahren kam der erste Star Wars Film in die Kinos? (25. Mai 1977 )
SELECT DATEDIFF(yyyy, '1977-05-25', GETDATE()) -- 43
SELECT DATEDIFF(yyyy, '1977-05-25', '2020-09-16')

-- da wir nur das Jahr abfragen, dürfen wir Tag und Monat auch weglassen!
SELECT DATEDIFF(yyyy, '1977', GETDATE())


-- In welchem Quartal liegt der österreichische Nationalfeiertag (26.10.)?

SELECT DATEPART(qq, '2020-10-26')
SELECT DATENAME(qq, '2020-10-26')




--Gib Tag, Monat und Jahr Deines Geburtstages in einer eigenen Spalte mit der jeweils entsprechenden Überschrift an
-- Tag	 Monat	 Jahr
--  22	  04	 1981

SELECT	  DATEPART(dd, '1981-04-22') AS Tag
		, DATEPART(MM, '1981-04-22') AS Monat
		, DATEPART(yyyy, '1981-04-22') AS Jahr


-- ******************** DAY, MONTH, YEAR ******************************

SELECT	  DAY('1981-04-22') AS Tag
		, MONTH('1981-04-22') AS Monat
		, YEAR('1981-04-22') AS Jahr 


-- mit DB:
SELECT BirthDate
FROM Employees


SELECT YEAR(BirthDate) AS GebDat
FROM Employees




-- Gib die drei Mitarbeiter, die als erste eingestellt wurden, aus (die schon am längsten beim Unternehmen sind).
-- Wähle nicht alle, sondern nur einige in diesem Zusammenhang sinnvolle Spalten aus.

SELECT TOP 3 
			  DATEPART(yyyy, HireDate) AS HireDate
			, CONCAT(FirstName, ' ', LastName)
FROM Employees
ORDER BY HireDate



SELECT TOP 3 
			  YEAR(HireDate) AS HireDate
			, CONCAT(FirstName, ' ', LastName)
FROM Employees
ORDER BY HireDate


SELECT TOP 3 
			  HireDate
			, FirstName
			, LastName
FROM Employees
ORDER BY HireDate