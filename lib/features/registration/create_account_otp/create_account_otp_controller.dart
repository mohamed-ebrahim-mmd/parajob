/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-27 2:42 PM
 ==================================================================
*/
import 'package:flutter/material.dart' show TextEditingController, BuildContext;
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart'
    show validatePin;
import 'package:para_job/packages/route_manager/controller/routes.dart'
    show Routes;
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

class CreateAccountOtpController extends GetxController {
  // TextEditingController for OTP / PIN input
  final pinController = TextEditingController();

  final String phoneNumber;

  // Validation error for the PIN input
  var pinError = RxnString(null);

  CreateAccountOtpController(this.phoneNumber);

  /// ✅ Validate and proceed with verifying OTP
  Future<void> verifyOtp(BuildContext context) async {
    pinError.value = validatePin(pinController.text);

    if (pinError.value == null) {
      await _verifyOtpRequest(context);
    }
  }

  /// ✅ API Call (to be implemented when backend endpoint is ready)
  Future<void> _verifyOtpRequest(BuildContext context) async {
    try {
      context.loaderOverlay.show();

      final response = await apiClient.verifyOtp(
        VerifyOtpRequest(
          phoneNumber: phoneNumber,
          otp: pinController.text.trim(),
        ),
      );

      if (response.isSuccess ?? false) {
        showSnackBarSuccess('Success', response.details?.message ?? '');
        Get.toNamed(
          "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}",
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
      context.loaderOverlay.hide();
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
    Get.delete<CreateAccountOtpController>(); // Dispose the controller
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
