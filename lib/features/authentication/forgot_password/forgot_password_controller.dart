/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-19
 ==================================================================
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/authentication/forgot_password_otp/forgot_password_otp_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

class ForgotPasswordController extends GetxController {
  // TextEditingController for the phone input
  final phoneController = TextEditingController();

  // Phone error state (null by default)
  var phoneError = RxnString(null);

  // Main method to trigger the process
  Future<void> forgotPassword() async {
    phoneError.value = validateEgyptianPhone(phoneController.text);

    if (phoneError.value == null) {
      await sendForgotPasswordRequest();
    }
  }

  // Send the forgot password request to API
  Future<void> sendForgotPasswordRequest() async {
    try {
      Get.context!.loaderOverlay.show();

      final response = await apiClient.sendOtp(
        SendOtpRequest(phoneNumber: phoneController.text),
      );

      if (response.isSuccess ?? false) {
        showSnackBarSuccess('Success', response.details?.message ?? '');
        //pass the phone number to the otp screen
        Get.put(ForgotPasswordOtpController(phoneNumber: phoneController.text));
        Get.toNamed("${Routes.forgotPassword}${Routes.forgotPasswordOTP}");
      } else {
        showSnackBarError(
          'Failed',
          response.details?.message ?? 'Unknown error',
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }

  // Dispose controllers
  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
