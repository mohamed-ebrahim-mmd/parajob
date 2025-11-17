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
  final createAccountController = Get.find<CreateAccountController>();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var passwordError = RxnString(null);
  var confirmPasswordError = RxnString(null);

  /// Validate both password fields
  Future<void> validateAndSubmit(BuildContext context) async {
    passwordError.value = validatePassword(passwordController.text.trim());
    confirmPasswordError.value = validateConfirmPassword(
      passwordController.text.trim(),
      confirmPasswordController.text.trim(),
    );

    if (passwordError.value == null && confirmPasswordError.value == null) {
      await _registerUserRequest(context);
    }
  }

  /// API request to register the user
  Future<void> _registerUserRequest(BuildContext context) async {
    try {
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

      log("🟢 Registration Request: $request");

      final response = await apiClient.registerUser(request);

      if (response.isSuccess ?? false) {
        showSnackBarSuccess(
          'success'.tr,
          response.details?.message ?? 'registration_completed'.tr,
        );

        Get.toNamed(
          "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}${Routes.createAccountFrontID}",
          arguments: {"tempToken": response.data?.token ?? "-"},
        );
      } else {
        showSnackBarError(
          'failed'.tr,
          response.details?.message ?? 'something_went_wrong'.tr,
        );
      }
    } catch (e) {
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
