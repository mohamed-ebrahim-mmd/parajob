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
  /// Text controller for OTP / PIN input
  final pinController = TextEditingController();

  final String phoneNumber;

  /// Validation error for the PIN input
  var pinError = RxnString(null);

  CreateAccountOtpController(this.phoneNumber);

  /// ✅ Validate PIN and verify OTP
  Future<void> verifyOtp(BuildContext context) async {
    pinError.value = validatePin(pinController.text);

    if (pinError.value == null) {
      await _verifyOtpRequest(context);
    }
  }

  /// ✅ API call to verify OTP
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
        showSnackBarSuccess('success'.tr, response.details?.message ?? '');
        Get.toNamed(
          "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}",
        );
      } else {
        showSnackBarError(
          'failed'.tr,
          response.details?.message ?? 'unknown_error'.tr,
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }

  /// Resend OTP for forgot password or account creation
  Future<void> resendOtpRequest(BuildContext context) async {
    try {
      context.loaderOverlay.show();

      final response = await apiClient.sendOtp(
        SendOtpRequest(phoneNumber: phoneNumber),
      );

      if (response.isSuccess ?? false) {
        showSnackBarSuccess('success'.tr, response.details?.message ?? '');
      } else {
        showSnackBarError(
          'failed'.tr,
          response.details?.message ?? 'unknown_error'.tr,
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }

  /// Close screen and dispose controller
  void closeAndDispose() {
    Get.back();
    Get.delete<CreateAccountOtpController>();
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
