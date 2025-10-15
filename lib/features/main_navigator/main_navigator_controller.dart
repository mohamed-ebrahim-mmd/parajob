/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-30 5:51 PM
 ==================================================================
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/Notifications/notifications_screen.dart';
import 'package:para_job/features/home/home_screen.dart';
import 'package:para_job/features/jobs/jobs_screen.dart';
import 'package:para_job/features/profile/profile_screen.dart';
import 'package:para_job/packages/ui_component/auth_required_dialog.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class MainNavigatorController extends GetxController {
  final userController = Get.find<UserController>();
  //  int? cartCount;
  //var cartCountApiCallState = ApiCallState.loading.obs;
  var tab = 0.obs; // Observable variable to track tab index
  // Navigation destinations

  // Pages for each destination
  final List<Widget> pages = [
    const HomeScreen(),
    const JobsScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  Future<void> updateTab(BuildContext context, int index) async {
    final UserController userController = Get.find();

    switch (index) {
      case 0:

        /// Home screen
        tab.value = index;
        break;
      case 1:

        /// if user isn't guest
        if (!userController.isGuest) {
          tab.value = index;
        } else {
          showAuthRequiredDialog();
        }
        break;

      case 2:

        /// if user isn't guest
        if (!userController.isGuest) {
          tab.value = index;
        } else {
          showAuthRequiredDialog();
        }
        break;

      case 3:

        // if user isn't guest
        if (!userController.isGuest) {
          tab.value = index;
        } else {
          showAuthRequiredDialog();
        }
        break;
    }
  }
}
