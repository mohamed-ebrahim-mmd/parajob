/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-19 3:45 PM
 ==================================================================
*/

import 'package:flutter/cupertino.dart' show TextEditingController;
import 'package:flutter/material.dart' show BuildContext;
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/authentication/set_new_password/set_new_password_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

class ForgotPasswordOtpController extends GetxController {
  // The phone number passed from the previous screen
  final String phoneNumber;

  // TextEditingController for OTP / PIN input
  final pinController = TextEditingController();

  // Validation error for the PIN input
  var pinError = RxnString(null);

  ForgotPasswordOtpController({required this.phoneNumber});

  /// ✅ Validate and proceed with verifying OTP
  Future<void> verifyOtp() async {
    pinError.value = validatePin(pinController.text);

    if (pinError.value == null) {
      await verifyOtpRequest();
    }
  }

  /// ✅ API Call (to be implemented when backend endpoint is ready)
  Future<void> verifyOtpRequest() async {
    try {
      Get.context!.loaderOverlay.show();

      final response = await apiClient.verifyOtp(
        VerifyOtpRequest(
          phoneNumber: phoneNumber,
          otp: pinController.text.trim(),
        ),
      );

      if (response.isSuccess ?? false) {
        showSnackBarSuccess('Success', response.details?.message ?? '');
        Get.put(SetNewPasswordController(phoneNumber: phoneNumber));
        Get.toNamed(
          "${Routes.forgotPassword}${Routes.forgotPasswordOTP}${Routes.setNewPassword}",
        );
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

  Future<void> resendForgotPasswordRequest(BuildContext context) async {
    try {
      context.loaderOverlay.show();

      final response = await apiClient.sendOtp(
        SendOtpRequest(phoneNumber: phoneNumber),
      );

      if (response.isSuccess ?? false) {
        showSnackBarSuccess('Success', response.details?.message ?? '');
      } else {
        showSnackBarError(
          'Failed',
          response.details?.message ?? 'Unknown error',
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }

  void closeAndDispose() {
    Get.back(); // Close the current screen
    Get.delete<ForgotPasswordOtpController>(); // Dispose the controller
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
