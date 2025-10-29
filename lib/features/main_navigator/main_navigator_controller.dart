
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/Notifications/notifications_screen.dart';
import 'package:para_job/features/home/home_screen.dart';
import 'package:para_job/features/my_jobs/my_jobs_screen.dart';
import 'package:para_job/features/profile/user_profile/profile_screen.dart';
import 'package:para_job/packages/ui_components/auth_required_dialog.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import '../my_notifications/my_notifications_screen.dart';

class MainNavigatorController extends GetxController {
  final userController = Get.find<UserController>();
  //  int? cartCount;
  //var cartCountApiCallState = ApiCallState.loading.obs;
  var tab = 0.obs; // Observable variable to track tab index
  // Navigation destinations

  // Pages for each destination
  late final List<Widget> pages = [
    HomeScreen(),
    MyJobsScreen(),
    MyNotificationScreen(),
    ProfileScreen(),
    userController.isGuest ? SizedBox() : MyJobsScreen(),
    userController.isGuest ? SizedBox() : NotificationsScreen(),
    userController.isGuest ? SizedBox() : ProfileScreen(),
  ];

  Future<void> updateTab(BuildContext context, int index) async {
    switch (index) {
      case 0:
        // Home tab can always be accessed
        tab.value = index;
        break;

      default:
        // For all other tabs, require authentication
        if (userController.isGuest) {
          showAuthRequiredDialog();
        } else {
          tab.value = index;
        }
        break;
    }
  }
}
