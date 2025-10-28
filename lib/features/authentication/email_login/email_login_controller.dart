/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-24 2:47 PM
 ==================================================================
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart'
    show Routes;
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

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
        Get.find<RoutingController>().goHomeAsUser(
            user!,
            "Bearer ${loginResponse.data!.token}",
          );
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
