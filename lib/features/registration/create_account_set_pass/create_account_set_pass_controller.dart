/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-27 3:19 PM
 ==================================================================
*/
import 'dart:developer';

import 'package:flutter/material.dart' show TextEditingController, BuildContext;
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/registration/create_account/create_account_controller.dart'
    show CreateAccountController;
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

class CreateAccountSetPassController extends GetxController {
  // Controllers for password fields
  final createAccountController = Get.find<CreateAccountController>();
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
      _registerUserRequest(context);

      // showSnackBarSuccess("Success", "Account created successfully");
    }
  }

  Future<void> _registerUserRequest(BuildContext context) async {
    try {
      // Show loading overlay
      context.loaderOverlay.show();

      final request = RegisterRequestModel(
        name: createAccountController.nameController.text.trim(),
        email: createAccountController.emailController.text.trim(),
        cityId: createAccountController.selectedCityId.value,
        areaId: createAccountController.selectedAreaId,
        phoneNumber: createAccountController.phoneController.text.trim(),
        gender: createAccountController.selectedGender,
        dateOfBirth: createAccountController.selectedDate.value,
        nationalId: createAccountController.nationalIdController.text.trim(),
        password: passwordController.text.trim(),
        passwordConfirmation: confirmPasswordController.text.trim(),
      );

      // Send API request
      final response = await apiClient.registerUser(request);
      log("🟢 ${request.toString()}");

      // Handle response
      if (response.isSuccess ?? false) {
        showSnackBarSuccess(
          'Success',
          response.details?.message ?? 'Registration completed successfully.',
        );
        Get.toNamed(
          "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}${Routes.createAccountFrontID}",
        );
      } else {
        showSnackBarError(
          'Failed',
          response.details?.message ??
              'Something went wrong, please try again.',
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      // Always hide the loader
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
