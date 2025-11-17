/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-19
 ==================================================================
*/

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/authentication/forgot_password_otp/forgot_password_otp_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

class ForgotPasswordController extends GetxController {
  final phoneController = TextEditingController();

  var phoneError = RxnString(null);

  Future<void> forgotPassword(BuildContext context) async {
    phoneError.value = validateEgyptianPhone(phoneController.text);

    if (phoneError.value == null) {
      await sendForgotPasswordRequest(context);
    }
  }

  Future<void> sendForgotPasswordRequest(BuildContext context) async {
    try {
      context.loaderOverlay.show();

      final response = await apiClient.sendOtp(
        SendOtpRequest(phoneNumber: phoneController.text),
      );

      if (response.isSuccess ?? false) {
        showSnackBarSuccess(
          "success_title".tr,
          response.details?.message ?? "",
        );

        Get.put(
          ForgotPasswordOtpController(
            phoneNumber: phoneController.text,
          ),
        );

        Get.toNamed(
          "${Routes.authChoice}${Routes.emailLoginScreen}${Routes.forgotPassword}${Routes.forgotPasswordOTP}",
        );
      } else {
        showSnackBarError(
          "failed_title".tr,
          response.details?.message ?? "unknown_error".tr,
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
    phoneController.dispose();
    super.onClose();
  }
}
