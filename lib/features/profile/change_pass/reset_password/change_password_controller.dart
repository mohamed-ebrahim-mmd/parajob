//Mary Mark ||  mary.mark@moselaymd.com || Tue Nov 11 2025 12:10:40



import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart'
    show Routes;
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class ChangePasswordController extends GetxController {
  final phoneNumber = Get.find<UserController>().user!.phoneNumber ?? '';

  // Controllers for password fields
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Error messages
  var passwordError = RxnString(null);
  var confirmPasswordError = RxnString(null);



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
              "${Routes.mainNavigator}${Routes.more}",
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

 
  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
