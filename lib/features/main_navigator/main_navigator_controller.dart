import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/home_screen.dart';
import 'package:para_job/features/my_jobs/my_jobs_screen.dart';
import 'package:para_job/features/my_notifications/my_notifications_controller.dart';
import 'package:para_job/features/profile/user_profile/profile_screen.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/api_client/src/models/responses/strike.dart';
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
  List<Strike> strikesData = [];

  void setUserProfilePic(String? profilePic) {
    userProfilePic.value = profilePic;
  }

  late final List<Widget> pages;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (userController.isGuest) {
      isBlockedCallState.value = ApiCallState.success;
      initPages();
    } else {
      fetchBlockStatus();
    }
    await checkInitialMessage();
    listenToForegroundMessages();
  }

  Future<void> checkInitialMessage() async {
    // Get the message that caused the app to open from a terminated state
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    if (initialMessage != null && !userController.isGuest) {
      // If the user is a guest, they  not be allowed to see notifications tab
      // So we check authentication status before switching
      tab.value = 2;
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

  Future<void> fetchBlockStatus() async {
    isBlockedCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchStrikes(userController.token!);

      if (response.isSuccess) {
        log("🟢 block status isSuccess");
        isBlocked = response.isBlocked;
        strikesData = response.data;

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

  void listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      // Refresh notifications if the controller is available
      if (Get.isRegistered<MyNotificationsController>()) {
        final notificationsController = Get.find<MyNotificationsController>();
        notificationsController.pagingController.refresh();
      }
    });
  }
}
