/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-24 4:15 PM
 ==================================================================
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
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
  Future<void> validateAndSubmit() async {
    passwordError.value = validatePassword(passwordController.text);
    confirmPasswordError.value = _validateConfirmPassword(
      passwordController.text,
      confirmPasswordController.text,
    );

    if (passwordError.value == null && confirmPasswordError.value == null) {
      await _submitNewPassword();
    }
  }

  /// ✅ Local confirm password validation
  String? _validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.trim().isEmpty) {
      return 'Confirm password cannot be empty';
    } else if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// ✅ Mock or actual API call
  Future<void> _submitNewPassword() async {
    try {
      Get.context!.loaderOverlay.show();

      // TODO: call API here when ready
      await Future.delayed(const Duration(seconds: 1));

      showSnackBarSuccess(
        "Success",
        "Password reset successfully for $phoneNumber",
      );
      Get.back(); // go back after success
    } catch (e) {
      showSnackBarError("Error", "Failed to reset password");
    } finally {
      Get.context!.loaderOverlay.hide();
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
