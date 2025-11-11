import 'dart:developer';

import 'package:flutter/material.dart' show BuildContext;
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/api_client/src/models/requests/apply_job_request.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/ui_components/auth_required_dialog.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import '../employer/employer_controller.dart';

class JobDetailsController extends GetxController {
  var jobDetailsCallState = ApiCallState.loading.obs;
  final user = Get.find<UserController>();
  JobDetailsResponse? jobData;
  final int jobId;
  JobDetailsController(this.jobId);
  @override
  void onInit() {
    super.onInit();
    fetchJobDetails(jobId);
  }

  Future<void> fetchJobDetails(int id) async {
    jobDetailsCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchJobDetails(
        id: id,
        token: user.token,
      );
      final companyId = response.data.company.id!;

      if (!Get.isRegistered<EmployerController>(tag: companyId.toString())) {
        final employerController = Get.put(
          EmployerController(companyId),
          tag: companyId.toString(),
        );

        ever(employerController.hasSubmittedReview, (submitted) {
          if (submitted == true) {
            fetchJobDetails(jobId);
            employerController.hasSubmittedReview.value = false;
          }
        });
      }

      if (response.isSuccess) {
        log("🟢 isSuccess");
        log("🟢 ${response.data.id}     ${response.data.title}  ${response.data.department.name} "    );

        jobData = response;

        jobDetailsCallState.value = ApiCallState.success;
      } else {
        jobDetailsCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("🟢 ${e.toString()}");
      jobDetailsCallState.value = ApiCallState.failure;
    }
  }

  Future<void> applyJob(BuildContext context, int jobId) async {
    if (user.isGuest) {
      showAuthRequiredDialog();
      return;
    }
    try {
      context.loaderOverlay.show();
      final response = await apiClient.applyJob(
        token: user.token!,
        request: ApplyJobRequest(jobId: jobId),
      );

      if (response.isSuccess == true) {
        fetchJobDetails(jobId);
        Get.offNamed(Routes.jobApplicationApplySuccess, arguments: jobId);
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

  Future<bool> withDrawJob(BuildContext context, int applicationId) async {
    var result = false;
    if (user.isGuest) {
      showAuthRequiredDialog();
      return result;
    }
    try {
      context.loaderOverlay.show();
      final response = await apiClient.withdrawJob(
        token: user.token!,
        applicationId: applicationId,
      );

      if (response.isSuccess == true) {
        fetchJobDetails(jobId);
        result = true;
      } else {
        showSnackBarError(
          'Failed',
          response.details?.message ?? 'Unknown error',
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      fetchJobDetails(jobId);
      context.loaderOverlay.hide();
    }
    return result;
  }
}
