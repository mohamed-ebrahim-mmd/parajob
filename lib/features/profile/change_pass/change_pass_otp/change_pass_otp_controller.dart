//Mary Mark ||  mary.mark@moselaymd.com || Tue Nov 11 2025 12:24:42

import 'package:flutter/cupertino.dart' show TextEditingController;
import 'package:flutter/material.dart' show BuildContext;
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class ChangePassOtpController extends GetxController {
  final phoneNumber = Get.find<UserController>().user!.phoneNumber ?? '';

  // TextEditingController for OTP / PIN input
  final pinController = TextEditingController();

  // Validation error for the PIN input
  var pinError = RxnString(null);

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
          "${Routes.mainNavigator}${Routes.more}${Routes.changePassOtp}${Routes.resetPassword}",
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

  Future<void> resendChangePasswordRequest(BuildContext context) async {
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
    Get.delete<ChangePassOtpController>(); // Dispose the controller
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
