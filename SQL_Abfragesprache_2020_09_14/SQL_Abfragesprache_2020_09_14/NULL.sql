-- NULL


-- NULL ist NICHT die Übersetzung vom deutschen "Null" ins Englische
-- NULL bedeutet, das Feld ist leer; leerer Wert

-- jede mathematische Operation mit NULL führt wieder zu NULL

-- wir können keine Vergleiche mit den üblichen Operatoren mit NULL anstellen (im WHERE)

-- wir können NICHT </>/<=/>=/= oder != NULL schreiben

-- wir müssten IS NULL oder IS NOT NULL abfragen

-- sonst: keine oder falsche Ergebnisse, aber keine Fehlermeldung!!!!