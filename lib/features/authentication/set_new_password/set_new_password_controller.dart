/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-24 4:15 PM
 ==================================================================
*/

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart'
    show Routes;
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

class SetNewPasswordController extends GetxController {
  // Phone number passed from previous screen
  final String phoneNumber;

  // Controllers for password fields
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Error messages
  var passwordError = RxnString(null);
  var confirmPasswordError = RxnString(null);

  SetNewPasswordController({required this.phoneNumber});

  /// ✅ Validate both password fields
  Future<void> validateAndSubmit(BuildContext context) async {
    passwordError.value = validatePassword(passwordController.text.trim());
    confirmPasswordError.value = validateConfirmPassword(
      passwordController.text.trim(),
      confirmPasswordController.text.trim(),
    );

    if (passwordError.value == null && confirmPasswordError.value == null) {
      await _submitNewPassword(context);
    }
  }

  /// ✅ Mock or actual API call
  Future<void> _submitNewPassword(BuildContext context) async {
    try {
      context.loaderOverlay.show();

      final response = await apiClient.resetPassword(
        ResetPasswordRequest(
          phoneNumber: phoneNumber,
          password: passwordController.text,
          passwordConfirmation: confirmPasswordController.text,
        ),
      );

      if (response.isSuccess ?? false) {
        showSnackBarSuccess(
          "Success",
          response.details?.message ?? "Password reset successfully",
        );
        Get.until(
          (route) =>
              Get.currentRoute ==
              "${Routes.authChoice}${Routes.emailLoginScreen}",
        );
      } else {
        showSnackBarError(
          "Failed",
          response.details?.message ?? "Password reset failed",
        );
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }

  void closeAndDispose() {
    Get.back();
    Get.delete<SetNewPasswordController>();
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
