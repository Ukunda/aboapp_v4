import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:aboapp/core/localization/app_localizations.dart';

void main() {
  group('AppLocalizations', () {
    late AppLocalizations localizations;

    setUp(() {
      localizations = AppLocalizations(const Locale('en'));
    });

    test('should translate basic keys', () async {
      // Load the translations
      await localizations.load();

      // Test basic translations
      expect(localizations.translate('ok'), equals('OK'));
      expect(localizations.translate('cancel'), equals('Cancel'));
      expect(localizations.translate('save'), equals('Save'));
    });

    test('should handle missing keys gracefully', () async {
      await localizations.load();

      // Test missing key
      expect(localizations.translate('non_existent_key'), equals('[non_existent_key]'));
    });

    test('should handle arguments in translations', () async {
      await localizations.load();

      // Test translation with arguments
      final result = localizations.translate('subscription_delete_confirm_message', args: {
        'name': 'Netflix'
      });
      
      expect(result, contains('Netflix'));
    });

    test('should handle pluralization', () async {
      await localizations.load();

      // Mock some plural keys for testing
      localizations._localizedStrings['item_singular'] = '{count} item';
      localizations._localizedStrings['item_plural'] = '{count} items';

      expect(localizations.plural('item_singular', 'item_plural', 1), equals('1 item'));
      expect(localizations.plural('item_singular', 'item_plural', 5), equals('5 items'));
    });

    test('should provide convenience getters', () async {
      await localizations.load();

      expect(localizations.ok, equals('OK'));
      expect(localizations.cancel, equals('Cancel'));
      expect(localizations.save, equals('Save'));
    });
  });

  group('AppLocalizations Delegate', () {
    const delegate = AppLocalizations.delegate;

    test('should support correct locales', () {
      expect(delegate.isSupported(const Locale('en')), isTrue);
      expect(delegate.isSupported(const Locale('de')), isTrue);
      expect(delegate.isSupported(const Locale('fr')), isTrue);
      expect(delegate.isSupported(const Locale('es')), isTrue);
      expect(delegate.isSupported(const Locale('unsupported')), isFalse);
    });

    test('should load localizations', () async {
      final localizations = await delegate.load(const Locale('en'));
      expect(localizations, isA<AppLocalizations>());
      expect(localizations.locale.languageCode, equals('en'));
    });

    test('should not reload unnecessarily', () {
      const oldDelegate = AppLocalizations.delegate;
      expect(delegate.shouldReload(oldDelegate), isFalse);
    });
  });
}