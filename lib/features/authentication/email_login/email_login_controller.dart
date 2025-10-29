/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-24 2:47 PM
 ==================================================================
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

import '../../../packages/route_manager/controller/routes.dart';

class EmailLoginController extends GetxController {
  // TextEditingController for email
  final emailController = TextEditingController();

  // TextEditingController for password
  final passwordController = TextEditingController();

  // Email error state (null by default)
  var emailError = RxnString(null);

  // Password error state (null by default)
  var passwordError = RxnString(null);

  Future<void> login() async {
    emailError.value = validateEmail(emailController.text);
    passwordError.value = validatePassword(passwordController.text);
    if (emailError.value == null && passwordError.value == null) {
      await loginUser();
    }
  }

  Future<void> loginUser() async {
    // Show loader overlay

    try {
      Get.context!.loaderOverlay.show();
      final loginResponse = await apiClient.loginWithMail(
        LoginWithMailRequest(
          email: emailController.text,
          password: passwordController.text,
        ),
      ); // Get posts by user ID

      if (loginResponse.isSuccess ?? false) {
        final user = loginResponse.data!.user;
        if (!(user?.isVerified ?? false)) {
          // 1️⃣ Not verified
          showSnackBarError(
            "Not Verified",
            "Please go to registration and create account.",
          );
        } else if ((user?.isVerified ?? false) &&
            !(user?.isCompleted ?? false)) {
          // 2️⃣ Verified but not complete
          showSnackBarError(
            "Incomplete Profile",
            "Please complete your registration.",
          );
          Get.toNamed(
            "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}${Routes.createAccountFrontID}",
          );
        } else if ((user?.isVerified ?? false) &&
            (user?.isCompleted ?? false) &&
            !(user?.isApproved ?? false)) {
          // 3️⃣ Waiting for admin approval
          showSnackBarSuccess(
            "Pending Approval",
            "Your account is awaiting admin approval. Please wait.",
          );
        } else if ((user?.isVerified ?? false) &&
            (user?.isCompleted ?? false) &&
            (user?.isApproved ?? false)) {
          // 4️⃣ All good — go to home
          Get.find<RoutingController>().goHomeAsUser(
            user!,
            "Bearer ${loginResponse.data!.token}",
          );
        }
      } else {
        showSnackBarError("Failed", "${loginResponse.details?.message} ");
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }

  // Dispose controllers when not needed
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
