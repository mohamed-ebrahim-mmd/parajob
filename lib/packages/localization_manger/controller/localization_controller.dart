import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationController extends GetxController {
  /// Stores the selected language code.
  /// Defaults to the english
  final _storedLanguage = 'en'.val('languageCode');

  /// Default locale for the app (English).
  static const Locale defaultLocale = Locale('en');

  /// Returns `true` if the current language is English.
  bool get isEnglish => _storedLanguage.val == 'en';

  /// Returns the current locale based on the stored language.
  /// Only supports predefined languages.
  Locale get currentLocale {
    switch (_storedLanguage.val) {
      case 'ar':
        return const Locale('ar'); // Arabic
      case 'en':
        return const Locale('en'); // English
      default:
        return defaultLocale; // Fallback to default locale
    }
  }

  /// Changes the app's language and updates storage.
  void changeLanguage(Locale? locale) {
    if (locale == null) return; // Prevent null values
    _storedLanguage.val = locale.languageCode; // Save new language
    Get.updateLocale(locale); // Apply new locale
  }
}
