/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-27 3:19 PM
 ==================================================================
*/
import 'package:flutter/material.dart' show TextEditingController, BuildContext;
import 'package:get/get.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

class CreateAccountSetPassController extends GetxController {
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
      /*      Get.toNamed(
        "${Routes.createAccount}${Routes.createAccountOTP}${Routes
            .createAccountSetPass}${Routes.createAccountFrontID}",
      );*/
      showSnackBarSuccess("Success", "Account created successfully");
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
