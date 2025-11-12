import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:para_job/packages/themeing/theme.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import 'packages/route_manager/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize GetStorage
  Get.put(RoutingController());
  Get.put(UserController());
  runApp(ParaJobApp());
}

class ParaJobApp extends StatelessWidget {
  final RoutingController routingController = Get.find();

  ParaJobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(context),
      themeMode: ThemeMode.dark,
      title: 'Para Job',
      initialRoute: routingController.getInitialRoute(),
      //Routes.companyDetails,
      //routingController.getInitialRoute(),
      // Routes.createAccount,
      // Set initial route based on stored state
      getPages: AppPages.pages,
    );
  }
}
