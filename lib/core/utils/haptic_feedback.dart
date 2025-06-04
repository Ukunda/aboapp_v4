import 'package:flutter/services.dart';

/// A utility class for providing haptic feedback.
/// This wraps the standard Flutter HapticFeedback methods for consistent use.
class HapticFeedback {
  HapticFeedback._(); // Private constructor to prevent instantiation.

  /// Provides a light haptic feedback.
  /// Typically used for minor interactions or successes.
  static Future<void> lightImpact() async {
    await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate', 'HapticFeedbackType.lightImpact');
    // Or using the direct method if you prefer and it suits your Flutter version's direct support:
    // await SystemSound.play(SystemSoundType.click); // This is more of a sound, but often used similarly
    // await HapticFeedback.lightImpact(); // Use this if your Flutter version has it directly and it's reliable.
  }

  /// Provides a medium haptic feedback.
  /// Suitable for more significant actions or confirmations.
  static Future<void> mediumImpact() async {
    await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate', 'HapticFeedbackType.mediumImpact');
    // await HapticFeedback.mediumImpact();
  }

  /// Provides a heavy haptic feedback.
  /// Best reserved for critical actions or errors.
  static Future<void> heavyImpact() async {
    await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate', 'HapticFeedbackType.heavyImpact');
    // await HapticFeedback.heavyImpact();
  }

  /// Provides a haptic feedback for a selection change.
  /// Commonly used in pickers or when an item selection changes.
  static Future<void> selectionClick() async {
    await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate', 'HapticFeedbackType.selectionClick');
    // await HapticFeedback.selectionClick();
  }

  /// Provides a warning haptic feedback pattern (not standard on all platforms).
  /// If specific warning patterns are needed, they might require platform-specific implementations
  /// or a plugin that offers more advanced haptics.
  /// For a simple alternative, you might use heavyImpact or a custom short vibration sequence.
  static Future<void> warningImpact() async {
    // iOS often has specific notification feedback types (success, warning, error)
    // Android is more generic. Heavy impact can serve as a general strong feedback.
    await heavyImpact(); 
  }
}