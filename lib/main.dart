import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:para_job/features/deep_link_loading/deep_link_loading_screen.dart';
import 'package:para_job/packages/functional_components/request_notification_permission.dart';
import 'package:para_job/packages/functional_components/subscribe_to_general_topic_notification.dart';
import 'package:para_job/packages/localization_manger/localization_manger.dart';
import 'package:para_job/packages/themeing/theme.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';
import 'package:para_job/res/firebase_options.dart';
import 'package:timeago/timeago.dart'
    as timeago
    show setLocaleMessages, ArShortMessages;

import 'packages/route_manager/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize GetStorage
  // Setup Async Dependencies
  // This blocks the app from starting until UserController.init() finishes
  await Get.putAsync<UserController>(() => UserController().init());
  // Load Arabic & English date formatting
  await initializeDateFormatting('ar', null);
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance.getInitialMessage();
  runApp(ParaJobApp());
}

class ParaJobApp extends StatefulWidget {
  const ParaJobApp({super.key});

  @override
  State<ParaJobApp> createState() => _ParaJobAppState();
}

class _ParaJobAppState extends State<ParaJobApp> {
  final RoutingController routingController = Get.put(RoutingController());
  final LocalizationController localizationController = Get.put(
    LocalizationController(),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await requestNotificationPermission(); // runs after first frame
      await subscribeToGeneralTopic();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: !kReleaseMode,
      theme: AppTheme.getTheme(context),
      themeMode: ThemeMode.dark,
      title: 'Para Job',
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child,
        );
      },
      initialRoute: routingController.getInitialRoute(),
      getPages: AppPages.pages,
      locale: localizationController.currentLocale,
      // Set the locale
      translations: AppTranslations(),
      // Load translations
      fallbackLocale: LocalizationController.defaultLocale,
      // Fallback to English
      unknownRoute: GetPage(
        name: Routes.deepLinkLoading,
        page: () => DeepLinkLoadingScreen(),
      ),
    );
  }
}
