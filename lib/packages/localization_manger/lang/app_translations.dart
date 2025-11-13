/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 15/02/2025 5:27 PM
 ==================================================================
*/
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'ar_sa.dart';
import 'en_us.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,
    'ar_SA': arSA,
  };
}
