import 'package:flutter/cupertino.dart' show TextEditingController;
import 'package:flutter/material.dart' show BuildContext;
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart' show PagingController;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/my_jobs/contract/contract_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/api_client/src/models/requests/application_verification_otp_request.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class ApplicationVerificationOtpController extends GetxController {
  final int jobId;
  final PagingController<int, MyJob> approvedJobController ;
  final user = Get.find<UserController>();

  final pinController = TextEditingController();

  var pinError = RxnString(null);

  ApplicationVerificationOtpController({required this.approvedJobController ,required this.jobId});

  Future<void> verifyOtp(BuildContext context) async {
    pinError.value = validatePin(pinController.text);
    if (pinError.value == null) {
      await _verifyOtpRequest(context);
    }
  }

  Future<void> _verifyOtpRequest(BuildContext context) async {
    try {
      context.loaderOverlay.show();

      final response = await apiClient.applicationVerificationOtp(
        token: user.token!,
        jobId: jobId,
        request: ApplicationVerificationOtpRequest(
          otp: pinController.text.trim(),
        ),
      );

      if (response.isSuccess ?? false) {
        Get.put(ContractController(jobId: jobId, approvedJobController: approvedJobController));
        Get.toNamed("${Routes.mainNavigator}${Routes.applicationVerificationOTP}${Routes.contract}");
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

  Future<void> resendApplicationVerificationRequest(
    BuildContext context,
  ) async {
    try {
      context.loaderOverlay.show();

      final response = await apiClient.sendOtp(
        SendOtpRequest(phoneNumber: user.user!.phoneNumber!.toString()),
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
    Get.back();
    Get.delete<ApplicationVerificationOtpController>();
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
