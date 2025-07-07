import 'package:flutter/material.dart';
import 'app_localizations.dart';

/// Debug overlay widget that helps identify missing translations in development
class LocalizationDebugOverlay extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const LocalizationDebugOverlay({
    super.key,
    required this.child,
    this.enabled = false,
  });

  @override
  State<LocalizationDebugOverlay> createState() => _LocalizationDebugOverlayState();
}

class _LocalizationDebugOverlayState extends State<LocalizationDebugOverlay> {
  final Set<String> _missingKeys = {};
  bool _showOverlay = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return Stack(
      children: [
        widget.child,
        if (_showOverlay) _buildDebugOverlay(),
        _buildToggleButton(),
      ],
    );
  }

  Widget _buildToggleButton() {
    return Positioned(
      top: 50,
      right: 16,
      child: FloatingActionButton.small(
        heroTag: "l10n_debug",
        backgroundColor: _missingKeys.isNotEmpty ? Colors.red : Colors.green,
        onPressed: () {
          setState(() {
            _showOverlay = !_showOverlay;
          });
        },
        child: Stack(
          children: [
            const Icon(Icons.translate, size: 20),
            if (_missingKeys.isNotEmpty)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${_missingKeys.length}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDebugOverlay() {
    return Positioned(
      top: 100,
      right: 16,
      left: 16,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.bug_report, color: Colors.red),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Localization Debug',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _showOverlay = false;
                      });
                    },
                  ),
                ],
              ),
              const Divider(),
              if (_missingKeys.isEmpty)
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Text('All translations found!'),
                  ],
                )
              else ...[
                Text(
                  'Missing Translations (${_missingKeys.length}):',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _missingKeys.map((key) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              const Icon(Icons.warning, color: Colors.orange, size: 16),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  key,
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Debug version of AppLocalizations that tracks missing keys
class DebugAppLocalizations extends AppLocalizations {
  final void Function(String key) onMissingKey;

  DebugAppLocalizations(super.locale, this.onMissingKey);

  @override
  String translate(String key, {Map<String, String>? args}) {
    String? translation = _localizedStrings[key];
    
    // Try fallback if translation not found
    if (translation == null && _fallbackStrings.isNotEmpty) {
      translation = _fallbackStrings[key];
    }
    
    // If still not found, track it
    if (translation == null) {
      onMissingKey(key);
      return '[MISSING: $key]'; // Make it obvious in debug mode
    }

    if (args != null && args.isNotEmpty) {
      args.forEach((argKey, argValue) {
        translation = translation!.replaceAll('{$argKey}', argValue);
      });
    }
    return translation!;
  }
}