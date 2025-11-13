import 'package:flutter/material.dart' show BuildContext, TextEditingController;
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/employer/employer_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class CompanyComplaintController extends GetxController {
  final user = Get.find<UserController>();
  final int id;
  final detailsController = TextEditingController();

  CompanyComplaintController(this.id);

  Future<void> complaint(BuildContext context) async {
    final details = detailsController.text.trim();
    if (details.isEmpty) {
      showSnackBarError(
        "Failed",
        "Please give some detail about your complain.",
      );
      return;
    }
    try {
      context.loaderOverlay.show();
      final response = await apiClient.companyComplaint(
        token: user.token!,
        request: CompanyComplaintRequest(companyId: id, details: details),
      );

      if (response.isSuccess == true) {
        detailsController.clear();
        // show success message and go back
        showSnackBarSuccess(
          "Success",
          response.details?.message ??
              "Your complaint has been submitted successfully.",
        );
        Get.find<EmployerController>().fetchCompany();
        Get.until(
          (route) =>
              Get.currentRoute == "${Routes.jobDetails}${Routes.employer}",
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

  @override
  void onClose() {
    detailsController.dispose();
    super.onClose();
  }
}
