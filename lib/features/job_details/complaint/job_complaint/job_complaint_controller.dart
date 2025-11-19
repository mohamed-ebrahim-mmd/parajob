import 'package:flutter/material.dart' show BuildContext, TextEditingController;
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/job_details/job_details_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class JobComplaintController extends GetxController {
  final user = Get.find<UserController>();
  final int id;
  final detailsController = TextEditingController();

  JobComplaintController(this.id);

  Future<void> complaint(BuildContext context) async {
    final details = detailsController.text.trim();
    if (details.isEmpty) {
      showSnackBarError("failed_title".tr, "complaint_empty_error".tr);
      return;
    }
    try {
      context.loaderOverlay.show();
      final response = await apiClient.jobComplaint(
        token: user.token!,
        request: JobComplaintRequest(jobId: id, details: details),
      );

      if (response.isSuccess == true) {
        detailsController.clear();

        // Refresh the JobDetailsController
        Get.find<JobDetailsController>(tag: id.toString()).fetchJobDetails(id);

        // Close the complaint screen
        Get.back();

        // Show job complaint success snackbar
        showSnackBarJobComplaintSuccess();
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }

  @override
  void onClose() {
    detailsController.dispose();
    super.onClose();
  }
}
