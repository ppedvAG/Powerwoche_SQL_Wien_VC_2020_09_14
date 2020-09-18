-- Serverfunktionen

-- ******************** TRIM, LEN, DATALENGTH ***********************************

SELECT 'Test'

SELECT 'Test     '


SELECT '    Test'


SELECT LEN('Test') -- 4
SELECT LEN('Test     ') -- 4! Leerzeichen am Ende werden nicht mitgezählt
SELECT LEN('     Test') -- 9 -- Leerzeichen am Anfang werden von LEN mitgezählt
SELECT LEN('Test     Text') -- 13 -- Leerzeichen in der Mitte werden von LEN mitgezählt



SELECT DATALENGTH('Test     ') -- 9 -- Leerzeichen am Ende werden mitgezählt

SELECT LTRIM('     Test') -- LTRIM: schneidet Leerzeichen davor weg
SELECT RTRIM('Test     ') -- RTRIM: schneidet Leerzeichen danach weg
SELECT TRIM('     Test     ') -- TRIM: schneidet Leerzeichen davor und danach weg



/*
Angenommen, durch einen Fehler gibt es Leerzeichen in einem String:
'    Test    '
.a) Entferne die Leerzeichen
.b) Gib die Länge des Strings vorher und nachher in einer Tabelle aus:
*/

SELECT	  DATALENGTH('     Test     ') AS Vorher
		, DATALENGTH(TRIM('     Test     ')) AS Nachher


-- *********************** REVERSE ***********************************
-- Text in umgekehrter Reihenfolge schreiben

SELECT REVERSE('REITTIER')
SELECT REVERSE('Trug Tim eine so helle Hose nie mit Gurt?')


-- **************************** LEFT, RIGHT, SUBSTRING *************************
-- Zeichen ausschneiden

SELECT LEFT('Testtext', 4) -- Test -- schneidet 4 Zeichen links aus
SELECT RIGHT('Testtext', 4) -- text -- schneidet 4 Zeichen rechts aus


SELECT SUBSTRING('Testtext', 4, 2) -- tt
-- von der 4. Stelle ausgehend schneiden wir 2 Zeichen aus


-- ******************************** STUFF **********************************
-- etwas einfügen/ersetzen

-- einfügen

SELECT STUFF('Testtext', 5, 0, '_Hallo_') -- Test_Hallo_text
-- von Stelle 5 ausgehend: 0 löschen, _Hallo_ einfügen

-- ersetzen
SELECT STUFF('Testtext', 4, 2, '_Hallo_') -- Tes_Hallo_ext
-- von Stelle 4 ausgehend: 2 löschen, _Hallo_ einsetzen


-- ************************** CONCAT ***********************************
-- Strings zusammenfügen

SELECT CONCAT('Test', 'text')
SELECT CONCAT('abc', 'def', 'ghi', 'jkl', 'mno', 'pqr', 'stu', 'vwx', 'yz')

SELECT CONCAT('Ich weiß, ', 'dass ich', ' nichts', ' ', 'weiß.') AS Zitat

SELECT CONCAT('James', ' ', 'Bond') AS FullName


SELECT CONCAT(FirstName, ' ', LastName) AS [Name Angestellte]
FROM Employees


SELECT ContactName
FROM Customers

/*
	Die letzten drei Stellen einer Telefonnummer sollen durch xxx ersetzt werden:
	z.B.:  +49 86779889xxx

	Bonus: die Lösung soll unabhängig von der Länge der Telefonnummer funktionieren

*/

-- Möglichkeit 1
SELECT STUFF('1234567890', 8, 3, 'xxx') -- von Stelle 8 ausgehend: lösche 3 weg und füge xxx hinzu
-- Vorsicht, geht nur bei gleicher Zeichenanzahl


-- Möglichkeit 2
SELECT LEFT('1234567890', 7) + 'xxx'  -- 1234567+xxx
SELECT CONCAT(LEFT('1234567890', 7), 'xxx')
-- Vorsicht: funktioniert nur bei gleicher Zeichenanzahl!


-- Möglichkeit 3
-- wieviele Zeichen sind es denn?
SELECT LEN('1234567890')

-- einsetzen in obiges Beispiel: 
SELECT LEFT('1234567890', 7) + 'xxx'
--->
-- wie kommen wir auf die 7?
SELECT LEN('1234567890')-3
-- wir berechnen, wie lange ist der Eintrag
-- und ziehen 3 ab
--> einsetzen:
SELECT LEFT('1234567890', LEN('1234567890')-3) + 'xxx'
SELECT CONCAT(LEFT('1234567890', LEN('1234567890')-3), 'xxx')


-- Möglichkeit 4
-- wie viele Zeichen sind hier enthalten?
SELECT LEN('1234567890')
-- wie komme ich auf die 8. Stelle?
SELECT LEN('1234567890')-2



--> einsetzen (statt 8: Berechnung, wie wir da hin kommen)
SELECT STUFF('1234567890', 8, 3, 'xxx')
--> statt 8 Berechnung einsetzen:
SELECT STUFF('1234567890', LEN('1234567890')-2, 3, 'xxx')


-- Möglichkeit 5
SELECT REVERSE(STUFF(REVERSE('1234567890'), 1, 3, 'xxx'))


-- langsam:
-- Nummer umdrehen, dann stehen die letzen Zeichen, unabhängig von der Länge des Eintrags am Anfang:
SELECT REVERSE('1234567890') -- 0987654321

-- die jetzt ersten 3 Zeichen mit X ersetzen:
SELECT STUFF('0987654321', 1, 3, 'xxx') -- xxx7654321

-- wieder umdrehen, damit sie wieder in der richtigen Reihenfolge stehen:
SELECT REVERSE('xxx7654321') -- 1234567xxx

-- zusammenbauen:
SELECT REVERSE(STUFF(REVERSE('1234567890'), 1, 3, 'xxx'))



-- mit DB:
SELECT    Phone
		, STUFF(Phone, LEN(Phone)-2, 3, 'xxx')
FROM Customers



SELECT    Phone
		, CONCAT(LEFT(Phone, LEN(Phone)-3), 'xxx')
FROM Customers



SELECT	  REVERSE(STUFF(REVERSE(Phone), 1, 3, 'xxx'))
		, Phone
FROM Customers


-- *************************** REPLICATE ************************************
-- Zeichen oder Zeichenfolgen mehrfach ausgeben

SELECT REPLICATE('?', 5) -- ?????
SELECT REPLICATE('x', 3) -- xxx
SELECT REPLICATE('abc', 3) -- abcabcabc


-- Groß- und Kleinschreibung
SELECT UPPER('test') -- TEST
SELECT LOWER('TEST') -- test

SELECT LOWER(FirstName)
FROM Employees

SELECT UPPER(FirstName)
FROM Employees


-- ***************************** REPLACE *****************************
-- bestimmte Zeichen ersetzen

SELECT REPLACE('Hallo!', 'a', 'e') -- Hello!

-- mehrere Zeichen ersetzen (verschachteln!)

SELECT REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?') -- Hello?

SELECT REPLACE(REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?'), 'H', 'B') -- Bello?



-- **************************** CHARINDEX ********************************
-- an welcher Stelle befindet sich ein bestimmtes Zeichen?

SELECT CHARINDEX('a', 'Leo') -- 0 (wenn es nicht vorkommt)

SELECT CHARINDEX('e', 'Leo') -- 2

SELECT CHARINDEX(' ', 'James Bond') -- 6

SELECT CHARINDEX(' ', 'Wolfgang Amadeus Mozart') -- 9

SELECT CHARINDEX('schnecke', 'Zuckerschnecke') -- 7

SELECT CHARINDEX('$', '450$') -- 4
SELECT CHARINDEX('%', '50%') -- 3

-- mit DB:
SELECT CHARINDEX(' ', ContactName)
FROM Customers


-- wie finde ich das letzte Leerzeichen?

-- langsam:
SELECT REVERSE('Wolfgang Amadeus Mozart') -- trazoM suedamA gnagfloW

-- letztes Leerzeichen -> erstes Leerzeichen im umgedrehten Text
SELECT CHARINDEX(' ', 'trazoM suedamA gnagfloW') -- 7

-- wieviele Zeichen sind es insgesamt?
SELECT LEN('Wolfgang Amadeus Mozart') -- 23

-- die 7 abziehen von der insgesamt Anzahl:
-- Anzahl an Zeichen vor unserem Leerzeichen:
-- 23-7 = 16
-- Stelle, an der sich dieses Leerzeichen befindet:
-- 16 + 1 = 17

-- einsetzen in 23 - 7 + 1 = Stelle, wo sich das Leerzeichen befindet

SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', 'trazoM suedamA gnagfloW') + 1 -- 17

-- Reverse einsetzen, um auf 'trazoM ...' zu kommen:
SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', REVERSE('Wolfgang Amadeus Mozart')) + 1 -- 17


-- funktioniert das auch für andere Namen?
SELECT LEN('Johann Sebastian Bach') - CHARINDEX(' ', REVERSE('Johann Sebastian Bach')) + 1 -- 17

SELECT LEN('Georg Friedrich Händel') - CHARINDEX(' ', REVERSE('Georg Friedrich Händel')) + 1 -- 16


-- das funktioniert auch mit DB:
-- im Fall von ContactName macht es nur nicht allzuviel Sinn (da gibt es nur ein Leerzeichen, also würde Charindex  reichen)
SELECT    LEN(ContactName) - CHARINDEX(' ', REVERSE(ContactName)) + 1 AS [letztes Leerzeichen]
		, CHARINDEX(' ', ContactName) AS [erstes Leerzeichen]
		, ContactName
FROM Customers
-- in DIESEM Fall (weil es nur ein einziges Leerzeichen gibt, exakt gleiches Ergebnis wie bei CHARINDEX)

-- letztes Leerzeichen im Firmennamen:
SELECT    CompanyName
		, LEN(CompanyName) - CHARINDEX(' ', REVERSE(CompanyName)) + 1 AS [letztes Leerzeichen]
FROM Customers



-- Von der Telefonnummer aus der Customers-Tabelle sollen nur die letzten 3 Zeichen angezeigt werden; alle anderen sollen mit x ersetzt werden. (xxxxxxxxxxxxxxx789)

-- STUFF hat 4 Parameter:
-- 1: expression (WORAN wollen wir etwas verändern)
-- 2: beginnend bei welcher Stelle
-- 3: wieviele Zeichen sollen gelöscht (ersetzt) werden (0, wenn wir keine löschen/ersetzen wollen, sondern nur einfügen)
-- 4: das, was wir einfügen wollen


SELECT STUFF('12345', 1, 2, 'xx')

SELECT STUFF('1234567890', 1, 7, 'xxxxxxx')
SELECT STUFF('1234567890', 1, 7, REPLICATE('x', 7))

-- wieviele sind es denn insgesamt:
SELECT LEN('1234567890')

-- wieviele möchten wir weglöschen? Anzahl insgesamt minus der letzten 3 Stellen:
SELECT LEN('1234567890') - 3

-- einsetzen:
SELECT STUFF('1234567890', 1, LEN('1234567890') - 3, REPLICATE('x', LEN('1234567890') - 3))


-- mit DB:
SELECT	  STUFF(Phone, 1, LEN(Phone) - 3, REPLICATE('x', LEN(Phone) - 3))
--		, Phone -- einblenden, um zu überprüfen, ob das stimmen kann
FROM Customers



-- andere Möglichkeit:

-- letzte 3 ausschneiden:
SELECT RIGHT('1234567890', 3) -- 890

SELECT SUBSTRING('1234567890', 8, 3) -- 890


-- x hinschreiben:
SELECT REPLICATE('x', 7) -- wieviele x brauchen wir? So viele, wie Zeichen davor waren.
SELECT REPLICATE('x', LEN('1234567890') - 3)

-- zusammenfügen:
-- SELECT CONCAT('James', ' ', 'Bond')
SELECT CONCAT(REPLICATE('x', LEN('1234567890') - 3), SUBSTRING('1234567890', 8, 3))

SELECT CONCAT(REPLICATE('x', LEN('1234567890') - 3), RIGHT('1234567890', 3))


-- unabhängig von Anzahl:
SELECT CONCAT(REPLICATE('x', LEN('1234567890') - 3), SUBSTRING('1234567890', LEN('1234567890')-2, 3))

SELECT CONCAT(REPLICATE('x', LEN('1234567890') - 3), RIGHT('1234567890', 3))


-- mit DB:
SELECT CONCAT(REPLICATE('x', LEN(Phone) - 3), SUBSTRING(Phone, LEN(Phone)-2, 3))
FROM Customers

SELECT CONCAT(REPLICATE('x', LEN(Phone) - 3), RIGHT(Phone, 3))
FROM Customers



















-- ***************** PATINDEX *************************
SELECT PATINDEX('%[0-9]%', 'lk4lkjlk') -- 3

