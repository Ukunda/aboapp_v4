# 🌍 Lokalisierung Migration Guide

## Übersicht
Diese Anleitung zeigt Ihnen, wie Sie von dem alten `translate()` System zu dem neuen offiziellen Flutter Lokalisierungssystem migrieren.

## 🔄 Syntax Migration

### Einfache Übersetzungen
```dart
// ❌ ALT
context.l10n.translate('app_title')

// ✅ NEU
context.l10n.app_title
```

### Übersetzungen mit Parametern
```dart
// ❌ ALT
context.l10n.translate('home_active_count', args: {'count': 5})

// ✅ NEU
context.l10n.home_active_count(5)
```

### Übersetzungen mit mehreren Parametern
```dart
// ❌ ALT
context.l10n.translate('settings_app_version', args: {'version': '1.0.0'})

// ✅ NEU
context.l10n.settings_app_version('1.0.0')
```

### Komplexe Übersetzungen mit mehreren Parametern
```dart
// ❌ ALT
context.l10n.translate('stats_salary_contribution_message', args: {
  'percentage': '15%',
  'salary': '€3,500'
})

// ✅ NEU
context.l10n.stats_salary_contribution_message('15%', '€3,500')
```

## 📋 Häufige Migrationsmuster

### 1. Einfache Texte
```dart
// Beispiele aus der App
context.l10n.translate('cancel') → context.l10n.cancel
context.l10n.translate('confirm') → context.l10n.confirm
context.l10n.translate('delete') → context.l10n.delete
context.l10n.translate('retry') → context.l10n.retry
context.l10n.translate('close') → context.l10n.close
```

### 2. Navigationselemente
```dart
// Bottom Navigation
context.l10n.translate('bottom_nav_subscriptions') → context.l10n.bottom_nav_subscriptions
context.l10n.translate('bottom_nav_statistics') → context.l10n.bottom_nav_statistics
context.l10n.translate('bottom_nav_settings') → context.l10n.bottom_nav_settings
```

### 3. Billing Cycles
```dart
// Billing Cycles
context.l10n.translate('billing_cycle_monthly') → context.l10n.billing_cycle_monthly
context.l10n.translate('billing_cycle_yearly') → context.l10n.billing_cycle_yearly
context.l10n.translate('billing_cycle_weekly') → context.l10n.billing_cycle_weekly
```

### 4. Kategorien
```dart
// Kategorien
context.l10n.translate('category_streaming') → context.l10n.category_streaming
context.l10n.translate('category_software') → context.l10n.category_software
context.l10n.translate('category_gaming') → context.l10n.category_gaming
```

## 🛠️ Automatische Migration

### Schritt 1: Einfache Ersetzungen
Verwenden Sie einen Text-Editor mit RegEx-Unterstützung:

**Suchen:**
```regex
context\.l10n\.translate\('([^']+)'\)
```

**Ersetzen:**
```
context.l10n.$1
```

### Schritt 2: Parametrisierte Übersetzungen
**Suchen:**
```regex
context\.l10n\.translate\('([^']+)',\s*args:\s*\{[^}]+\}\)
```

**Ersetzen:** (Manuell - da Parameter-Reihenfolge wichtig ist)

## 📖 Vollständige Beispiele

### Beispiel 1: Settings Screen
```dart
// ❌ ALT
ListTile(
  title: Text(context.l10n.translate('settings_theme_title')),
  subtitle: Text(_getThemeDisplayName(context, selectedTheme)),
  trailing: Icon(Icons.brightness_6),
  onTap: () => _showThemeDialog(context),
)

// ✅ NEU
ListTile(
  title: Text(context.l10n.settings_theme_title),
  subtitle: Text(_getThemeDisplayName(context, selectedTheme)),
  trailing: Icon(Icons.brightness_6),
  onTap: () => _showThemeDialog(context),
)
```

### Beispiel 2: Home Screen mit Parametern
```dart
// ❌ ALT
Text(context.l10n.translate('home_active_count', args: {'count': activeCount}))

// ✅ NEU
Text(context.l10n.home_active_count(activeCount))
```

### Beispiel 3: Delete Confirmation
```dart
// ❌ ALT
AlertDialog(
  title: Text(context.l10n.translate('subscription_delete_confirm_title')),
  content: Text(context.l10n.translate('subscription_delete_confirm_message', args: {'name': subscription.name})),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(context.l10n.translate('cancel')),
    ),
    TextButton(
      onPressed: () => _deleteSubscription(context, subscription),
      child: Text(context.l10n.translate('delete')),
    ),
  ],
)

// ✅ NEU
AlertDialog(
  title: Text(context.l10n.subscription_delete_confirm_title),
  content: Text(context.l10n.subscription_delete_confirm_message(subscription.name)),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(context.l10n.cancel),
    ),
    TextButton(
      onPressed: () => _deleteSubscription(context, subscription),
      child: Text(context.l10n.delete),
    ),
  ],
)
```

## 🎯 Spezielle Fälle

### 1. Pluralisierung
```dart
// ❌ ALT
context.l10n.translate('subscription_count', args: {'count': count})

// ✅ NEU
context.l10n.home_active_count(count)  // Automatische Pluralisierung
```

### 2. Datum und Zeit
```dart
// ❌ ALT
context.l10n.translate('subscription_card_days_until_label_prefix')

// ✅ NEU
context.l10n.subscription_card_days_until_label_prefix
```

### 3. Komplexe Formatierungen
```dart
// ❌ ALT
context.l10n.translate('stats_spending_trend_title', args: {'year': '2024'})

// ✅ NEU
context.l10n.stats_spending_trend_title('2024')
```

## 📝 Checklist für die Migration

### Vorbereitung
- [ ] Backup des Projekts erstellen
- [ ] Alle Tests ausführen (vor der Migration)
- [ ] Generierte Lokalisierungsdateien prüfen

### Migration
- [ ] Alle `translate()` Aufrufe ohne Parameter ersetzen
- [ ] Parametrisierte `translate()` Aufrufe manuell überprüfen
- [ ] Import-Statements aktualisieren
- [ ] Extension importieren wo nötig

### Nachbereitung
- [ ] Alle Dateien kompilieren
- [ ] Tests ausführen
- [ ] App in beiden Sprachen testen
- [ ] Hot Reload/Hot Restart testen

## 🔧 Häufige Probleme und Lösungen

### Problem 1: "translate method not found"
**Lösung:** Stellen Sie sicher, dass Sie die Extension importiert haben:
```dart
import 'package:aboapp/core/localization/l10n_extensions.dart';
```

### Problem 2: Parameter-Reihenfolge
**Lösung:** Prüfen Sie die ARB-Datei für die korrekte Parameter-Reihenfolge:
```json
{
  "stats_salary_contribution_message": "Subscriptions make up {percentage} of your {salary} salary",
  "@stats_salary_contribution_message": {
    "placeholders": {
      "percentage": {"type": "String"},
      "salary": {"type": "String"}
    }
  }
}
```

### Problem 3: Fehlende Übersetzungen
**Lösung:** Fügen Sie fehlende Schlüssel zu beiden ARB-Dateien hinzu.

## 🚀 Nächste Schritte

1. **Schrittweise Migration:** Migrieren Sie einen Screen/Feature nach dem anderen
2. **Testen:** Testen Sie jede Sprache nach der Migration
3. **Dokumentation:** Aktualisieren Sie die Entwicklerdokumentation
4. **Team-Schulung:** Stellen Sie sicher, dass alle Entwickler das neue System verstehen

## 📚 Zusätzliche Ressourcen

- [Flutter Internationalization Guide](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
- [ARB File Format](https://github.com/google/app-resource-bundle)
- [App Localizations API](https://api.flutter.dev/flutter/flutter_localizations/GlobalMaterialLocalizations-class.html)

---

**Tipp:** Verwenden Sie die `L10nHelpers` Klasse für häufig verwendete Formatierungen und Hilfsfunktionen!