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
  final String phoneNumber;

  final pinController = TextEditingController();

  var pinError = RxnString(null);

  ForgotPasswordOtpController({required this.phoneNumber});

  Future<void> verifyOtp(BuildContext context) async {
    pinError.value = validatePin(pinController.text);

    if (pinError.value == null) {
      await _verifyOtpRequest(context);
    }
  }

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
        showSnackBarSuccess(
          "success_title".tr,
          response.details?.message ?? "",
        );

        Get.put(SetNewPasswordController(phoneNumber: phoneNumber));

        Get.toNamed(
          "${Routes.authChoice}"
          "${Routes.emailLoginScreen}"
          "${Routes.forgotPassword}"
          "${Routes.forgotPasswordOTP}"
          "${Routes.setNewPassword}",
        );
      } else {
        showSnackBarError(
          "failed_title".tr,
          response.details?.message ?? "unknown_error".tr,
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
        showSnackBarSuccess(
          "success_title".tr,
          response.details?.message ?? "",
        );
      } else {
        showSnackBarError(
          "failed_title".tr,
          response.details?.message ?? "unknown_error".tr,
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }

  void closeAndDispose() {
    Get.back();
    Get.delete<ForgotPasswordOtpController>();
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
