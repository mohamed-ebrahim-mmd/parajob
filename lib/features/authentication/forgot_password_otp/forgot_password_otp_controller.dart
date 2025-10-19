/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-19 3:45 PM
 ==================================================================
*/

import 'package:flutter/cupertino.dart' show TextEditingController;
import 'package:get/get.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';

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
      // await verifyOtpRequest();
    }
  }

  /*  /// ✅ API Call (to be implemented when backend endpoint is ready)
  Future<void> verifyOtpRequest() async {
    try {
      Get.context!.loaderOverlay.show();

      // TODO: Replace this with the actual API endpoint when available
      // Example:
      // final response = await apiClient.verifyOtp(VerifyOtpRequest(
      //   phoneNumber: phoneNumber,
      //   otp: pinController.text,
      // ));

      await Future.delayed(const Duration(seconds: 1)); // mock delay
      showSnackBarSuccess(
        "Success",
        "OTP verified successfully for $phoneNumber",
      );

      // TODO: navigate to reset password or next step
    } catch (e) {
      showSnackBarError("Error", "Failed to verify OTP");
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }*/

  void closeAndDispose() {
    Get.back(); // Close the current screen
    Get.delete<ForgotPasswordOtpController>(); // Dispose the controller
  }

  /*
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
*/

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
