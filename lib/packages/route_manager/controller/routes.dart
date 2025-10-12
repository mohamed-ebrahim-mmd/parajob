/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 23/02/2025 8:17 AM
 ==================================================================
*/

import 'package:get/get.dart';
import 'package:para_job/features/authentication/forgot_password/forgot_password_screen.dart';
import 'package:para_job/features/authentication/login/login_screen.dart';
import 'package:para_job/features/authentication/register/register_screen.dart';
import 'package:para_job/features/main_navigator/main_navigator_screen.dart';
import 'package:para_job/features/onboarding/onboarding_screen.dart';

class Routes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String mainNavigator = '/';
  static const String forgotPassword = '/forgot-password';
  static const String register = '/register';
  static const String info = '/info';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.onboarding, page: () => OnboardingScreen()),
    GetPage(name: Routes.login, page: () => LoginScreen()),
    GetPage(name: Routes.forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: Routes.register, page: () => RegisterScreen()),
    GetPage(name: Routes.mainNavigator, page: () => MainNavigatorScreen()),
  ];
}
