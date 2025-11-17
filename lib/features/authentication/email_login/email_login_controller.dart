/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-24 2:47 PM
 ==================================================================
*/

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

import '../../../packages/route_manager/controller/routes.dart';

class EmailLoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var emailError = RxnString(null);
  var passwordError = RxnString(null);

  Future<void> login() async {
    emailError.value = validateEmail(emailController.text);
    passwordError.value = validatePassword(passwordController.text);

    if (emailError.value == null && passwordError.value == null) {
      await loginUser();
    }
  }

  Future<void> loginUser() async {
    try {
      Get.context!.loaderOverlay.show();

      final loginResponse = await apiClient.loginWithMail(
        LoginWithMailRequest(
          email: emailController.text,
          password: passwordController.text,
        ),
      );

      if (loginResponse.isSuccess ?? false) {
        final user = loginResponse.data!.user;
        log("🟢 ${loginResponse.data?.token}");

        // 1️⃣ Not verified
        if (!(user?.isVerified ?? false)) {
          showSnackBarError("not_verified_title".tr, "not_verified_message".tr);
        }
        // 2️⃣ Verified but profile not completed
        else if (!(user?.isCompleted ?? false)) {
          showSnackBarError(
            "incomplete_profile".tr,
            "please_complete_registration".tr,
          );

          Get.toNamed(
            "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}${Routes.createAccountFrontID}",
            arguments: {"tempToken": loginResponse.data?.token ?? "-"},
          );
        }
        // 3️⃣ Completed but not approved
        else if (!(user?.isApproved ?? false)) {
          showSnackBarError(
            "pending_approval_title".tr,
            "pending_approval_message".tr,
          );
        }
        // 4️⃣ Verified + completed + approved → go home
        else {
          final tokenSuccess = await _sendDeviceTokenToBackend(
            "Bearer ${loginResponse.data!.token}",
          );

          if (tokenSuccess) {
            Get.find<RoutingController>().goHomeAsUser(
              user!,
              "Bearer ${loginResponse.data!.token}",
            );
          }
        }
      } else {
        showSnackBarError("failed_title".tr, "${loginResponse.details?.message}");
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      showSnackBarApiError();
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }

  Future<bool> _sendDeviceTokenToBackend(String userToken) async {
    try {
      String? deviceToken = await FirebaseMessaging.instance.getToken();

      final request = NotificationTokenRequest(deviceToken: deviceToken ?? "-");

      final response = await apiClient.updateDeviceToken(request, userToken);

      if (response.isSuccess) {
        return true;
      } else {
        showSnackBarError("failed".tr, "${response.details.message}");
        return false;
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      showSnackBarApiError();
      return false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
