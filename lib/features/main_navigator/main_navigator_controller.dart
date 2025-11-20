import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/home_screen.dart';
import 'package:para_job/features/my_jobs/my_jobs_screen.dart';
import 'package:para_job/features/profile/user_profile/profile_screen.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/api_client/src/service/api_client_instance.dart';
import 'package:para_job/packages/ui_components/auth_required_dialog.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import '../my_notifications/my_notifications_screen.dart';

class MainNavigatorController extends GetxController {
  final userController = Get.find<UserController>();
  var tab = 0.obs; // Observable variable to track tab index
  var userProfilePic = Rx<String?>(null);
  var isBlockedCallState = ApiCallState.loading.obs;
  bool isBlocked = false;

  void setUserProfilePic(String? profilePic) {
    userProfilePic.value = profilePic;
  }
  late final List<Widget> pages;

  @override
  void onInit() {
    super.onInit();
    if (userController.isGuest) {
      isBlockedCallState.value = ApiCallState.success;
      initPages();

    } else {
      fetchProfileDetails();
    }
  }
 // Pages for each destination
  void initPages() {
    pages = [
      HomeScreen(),
      userController.isGuest ? SizedBox() : MyJobsScreen(),
      userController.isGuest ? SizedBox() : MyNotificationScreen(),
      userController.isGuest ? SizedBox() : ProfileScreen(),
    ];
  }

  Future<void> fetchProfileDetails() async {
    isBlockedCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchUserProfile(
        token: userController.token!,
      );

      if (response.isSuccess) {
        log("🟢 fetchProfileDetails isSuccess");
        var profileData = response.data;

       isBlocked = profileData.isBlocked ?? false;
        if (!isBlocked) {
          initPages();
        }
        isBlockedCallState.value = ApiCallState.success;
      } else {
        isBlockedCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      isBlockedCallState.value = ApiCallState.failure;
    }
  }

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
