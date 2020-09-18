USE Northwind


-- einfache Abfragen

-- Text, Zahlen, Berechnungen im SELECT


SELECT 'Testtext'


SELECT 100


SELECT 100*3


SELECT '100*3'


SELECT 'Testtext', 100, 'mehr Text'


SELECT 'Testtext' AS Spaltenüberschrift



-- Übersichtlichkeit?

SELECT	  'Testtext',
		  100, -- verantworlich für die Fehlermeldung, nach dem Komma müsste noch eine Spalte angegeben werden
--		  'mehr Text'



-- schönere Variante:
SELECT	  'Testtext'  -- wird als Fehler angezeigt wegen Komma oben
		, 100
		, 'mehr Text'



SELECT 100
GO -- Batch Delimiter


SELECT	  100 AS Zahl
		, 'Donaudampfschifffahrtsgesellschaft' AS [Text]
		, 100*2 AS Rechnung




SELECT	  100 AS Zahl
		, 'Donaudampfschifffahrtsgesellschaft' AS [Mein Text]
		, 100*2 AS Rechnung







