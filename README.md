# aboapp_v4

## Projektbeschreibung
AboApp verwaltet deine Abonnements, analysiert deren Kosten und bietet Salary Insights, damit du deine Finanzen stets im Blick hast. Zu den Hauptfunktionen zählen:

- **Subscription-Verwaltung** zum einfachen Hinzufügen und Kündigen von Verträgen
- **Statistiken** mit Diagrammen und Übersichten deiner Ausgaben
- **Salary Insights** zur Planung deines Budgets im Monatsverlauf

## Installation
1. Stelle sicher, dass Flutter installiert ist.
2. Führe `flutter pub get` aus, um alle Abhängigkeiten zu laden.
3. Starte ein Gerät oder einen Emulator und führe `flutter run` aus.

Unterstützte Plattformen: Android, iOS, Web und Desktop (Windows, macOS, Linux).

## Weitere Informationen
- [Datenschutzerklärung](PRIVACY_POLICY.md)
- [Taskliste](Tasklist.md)

## Android Signing
Um eine signierte Android-App zu bauen, muss ein Keystore erstellt und die Zugangsdaten in einer Datei `key.properties` hinterlegt werden. Dies ist optional und wird nur verwendet, wenn `key.properties` vorhanden ist.

### Keystore erstellen
Führe im Projektverzeichnis folgendes Kommando aus:

```bash
keytool -genkeypair -v \
  -keystore upload-keystore.jks \
  -keyalg RSA -keysize 2048 \
  -validity 10000 \
  -alias upload
```

Lege das erzeugte `upload-keystore.jks` zum Beispiel im Ordner `android/` ab.

### key.properties anlegen
Erstelle anschließend eine Datei `key.properties` im Projektstamm mit folgendem Inhalt und passe die Werte an dein Keystore an:

```properties
storePassword=<store-passwort>
keyPassword=<key-passwort>
keyAlias=upload
storeFile=android/upload-keystore.jks
```

Beim Build liest Gradle diese Datei automatisch ein und verwendet die Angaben zum Signieren des Release-Builds.
