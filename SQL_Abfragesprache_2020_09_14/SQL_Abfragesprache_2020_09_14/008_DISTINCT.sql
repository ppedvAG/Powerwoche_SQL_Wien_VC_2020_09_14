-- DISTINCT

-- alle Länder, in die wir liefern?
SELECT Country
FROM Customers
-- Ergebnis: so viele wie Kunden; wenn in einem Land mehrere Kunden vorhanden sind, wird das Land entsprechend öfter angezeigt



-- Liste von allen Ländern, in die ich liefere (also jedes Land nur einmal)
SELECT DISTINCT Country
FROM Customers



-- mehrere Spalten möglich?
-- ja
-- Sinn? von Fall zu Fall entscheiden!


SELECT DISTINCT Country, CustomerID
FROM Customers
-- macht keinen Sinn! So viele Ergebnisse, wie CustomerID


SELECT DISTINCT Country, City
FROM Customers
-- So viele Ergebnisse, wie Städte (Land steht öfter da, wenn wir in einem Land mehrere Städte haben)


SELECT DISTINCT Country, Region
FROM Customers
-- So viele Ergebnisse, wie es Regionen gibt (in machen Ländern gibt es mehrere Regionen)


-- Liste von allen Städten, in denen wir Kunden haben?
SELECT DISTINCT City
FROM Customers


-- Liste von allen Ländern, in denen Angestellte wohnen?
SELECT DISTINCT Country
FROM Employees
-- UK, USA

-- überprüfen:
SELECT Country 
FROM Employees
ORDER BY Country
-- stimmt, nur in UK und in den USA


