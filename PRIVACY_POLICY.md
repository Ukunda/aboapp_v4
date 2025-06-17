# Datenschutzerklärung für AboApp

**Letzte Aktualisierung:** 17. Juni 2025

Vielen Dank, dass Sie AboApp nutzen! Der Schutz Ihrer persönlichen Daten hat für uns höchste Priorität. Diese Datenschutzerklärung erläutert, welche Daten wir erfassen, wie wir sie verwenden und wie wir sie schützen.

## 1. Verantwortliche Stelle

**Firma:** Nulltron  
**Kontakt-E-Mail:** nulltronofficials@gmail.com

## 2. Welche Daten wir erfassen

Das Grundprinzip von AboApp ist es, Ihre Daten auf Ihrem Gerät zu belassen. Wir erfassen nur die Informationen, die für die Funktionalität der App zwingend notwendig sind.

### Von Ihnen bereitgestellte Daten

* **Abonnement-Daten:** Wenn Sie ein Abonnement hinzufügen, speichern wir die von Ihnen eingegebenen Informationen wie Name des Dienstes, Preis, Abrechnungszyklus, nächstes Zahlungsdatum und optional Notizen oder Beschreibungen.
* **Gehaltsdaten (Optional):** Um Ihnen Einblicke in Ihr Ausgabeverhalten zu geben, können Sie optional Ihr Gehalt und den Zahlungsrhythmus angeben. Diese Funktion ist freiwillig und für die Kernfunktionalität der App nicht erforderlich.
* **App-Einstellungen:** Wir speichern Ihre gewählten Einstellungen wie das Design (Hell/Dunkel), die Sprache und die Währung.

### Automatisch erfasste Daten

Die App selbst sammelt **keine** persönlichen Daten automatisch für Werbe- oder Analysezwecke. Im Falle eines App-Absturzes können anonymisierte Diagnosedaten (wie Gerätetyp und Betriebssystemversion) vom Flutter-Framework erfasst werden, um uns bei der Fehlerbehebung zu helfen. Diese Daten enthalten keine persönlichen Informationen von Ihnen.

## 3. Wie wir Ihre Daten speichern und schützen

Der Schutz Ihrer Daten ist das Kernstück unserer Architektur.

* **Lokale Speicherung:** Alle von Ihnen eingegebenen Daten werden **ausschließlich lokal auf Ihrem Gerät** gespeichert. Es findet keine Übertragung an einen von uns betriebenen Server statt.
* **Verschlüsselung:** Wir verwenden `flutter_secure_storage`, um Ihre Daten sicher im verschlüsselten Speicher Ihres Geräts (z.B. Keychain auf iOS, Keystore auf Android) abzulegen. Dies bietet einen robusten Schutz vor unbefugtem Zugriff.

## 4. Wie wir Ihre Daten verwenden

Wir verwenden Ihre Daten ausschließlich, um Ihnen die Funktionen von AboApp bereitzustellen:

* Zur Anzeige und Verwaltung Ihrer Abonnements.
* Zur Berechnung und Darstellung Ihrer monatlichen und jährlichen Ausgaben.
* Zur Erstellung von lokalen Statistiken und Diagrammen über Ihr Ausgabeverhalten.
* Um Sie (falls aktiviert) an bevorstehende Zahlungen zu erinnern.

## 5. Weitergabe Ihrer Daten

**Wir geben Ihre persönlichen Daten nicht an Dritte weiter.**

Da alle Ihre sensiblen Daten nur lokal gespeichert sind, gibt es keine zentrale Datenbank, von der Daten weitergegeben werden könnten. Die einzige Ausnahme sind notwendige Netzwerkverbindungen, die nicht von uns kontrolliert werden:

* **Logo-Downloads:** Wenn Sie eine URL für ein Abonnement-Logo angeben, lädt die App dieses Bild über das Internet herunter. Dabei wird eine Verbindung zu dem von Ihnen angegebenen Server hergestellt.

## 6. Ihre Rechte und Datenlöschung

Sie haben die volle Kontrolle über Ihre Daten.

* **Zugriff und Korrektur:** Sie können jederzeit alle Ihre eingegebenen Daten innerhalb der App einsehen und bearbeiten.
* **Löschung:** Sie können einzelne Abonnements direkt in der App löschen. Um **alle Ihre Daten vollständig zu löschen**, deinstallieren Sie einfach die App von Ihrem Gerät. Da keine Daten auf externen Servern gespeichert werden, werden bei der Deinstallation alle zugehörigen Informationen restlos entfernt.

## 7. Änderungen dieser Datenschutzerklärung

Wir können diese Datenschutzerklärung von Zeit zu Zeit aktualisieren, um Änderungen an unseren Praktiken widerzuspiegeln oder aus anderen betrieblichen, rechtlichen oder regulatorischen Gründen.