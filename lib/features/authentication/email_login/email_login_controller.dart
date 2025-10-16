/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-24 2:47 PM
 ==================================================================
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
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
      /*
      final loginResponse = await apiClient.login(
        LoginRequest(
          email: emailController.text,
          password: passwordController.text,
        ),
      ); // Get posts by user ID
*/
      await Future.delayed(const Duration(seconds: 2), () {});

      if (false) {
        /// if the request is success and the emil is verified
        if (true) {
          /*    showSnackbarSuccess("success".tr,
              isEng ? loginResponse.message : loginResponse.messageAr);*/
          showSnackBarSuccess("got to home screen".tr, "home");
        }
        /// if the request is success but the email is not verified
        else {
          showSnackBarError("email is not verfied ", "falied");
        }
      } else {
        showSnackBarError("failed".tr, "falied");
      }
    } catch (e) {
      showSnackBarError("failed".tr, "");
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
