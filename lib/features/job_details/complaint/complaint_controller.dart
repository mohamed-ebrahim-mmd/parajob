import 'package:flutter/material.dart' show BuildContext, TextEditingController;
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/job_details/complaint/complaint_success_dialog.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/api_client/src/models/requests/company_complaint_request.dart';
import 'package:para_job/packages/api_client/src/models/requests/job_complaint_request.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class ComplaintController extends GetxController {
  final user = Get.find<UserController>();
  final int id;
  final bool isCompany;
  final detailsController = TextEditingController();
  ComplaintController(this.id, this.isCompany);

  Future<void> complaint(BuildContext context) async {
    final details = detailsController.text.trim();
    if ( details.isEmpty) {
      showSnackBarError(
        "Warning",
        "Please select a write a details.",
      );
      return;
    }
    try {
      context.loaderOverlay.show();
      final BaseResponse response;
      if (isCompany == true) {
        response = await apiClient.companyComplaint(
          token: user.token!,
          request: CompanyComplaintRequest(companyId: id, details: details),
        );
      } else {
        response = await apiClient.jobComplaint(
          token: user.token!,
          request: JobComplaintRequest(jobId: id, details: details),
        );
      }

      if (response.isSuccess == true) {
        detailsController.clear();
        complaintSuccessDialog();

      } else {
        showSnackBarError(
          'Failed',
          response.details?.message ?? 'Unknown error',
        );
      }
    } catch (e) {
      print('eeeee');
      print(e);
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }
}
