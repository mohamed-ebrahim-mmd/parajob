//Mary Mark ||  mary.mark@moselaymd.com || Tue Dec 02 2025 17:10:28

/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-24 4:15 PM
 ==================================================================
*/

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/api_client/src/models/responses/job_interview_data.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class InterviewController extends GetxController {
  final token = Get.find<UserController>().token;
  InterviewData? interviewData;
  var interviewCallState = ApiCallState.loading.obs;
  final int id;
  InterviewController({required this.id});
  @override
  void onInit() {
    super.onInit();
    fetchInterviewData(id);
  }

  Future<void> fetchInterviewData(int id) async {
    interviewCallState.value = ApiCallState.loading;
    log("🔴   $id");
    try {
      final response = await apiClient.getInterviewDetails(
        jobId: 39,
        token: token!,
      );

      if (response.isSuccess) {
        interviewData = response.data;
        interviewCallState.value = ApiCallState.success;
      } else {
        interviewCallState.value = ApiCallState.failure;
        log("🔴   ${response.details.message}");
      }
    } catch (e) {
      interviewCallState.value = ApiCallState.failure;
      log("🔴${e.toString()}");
    }
  }

  Future<void> sendInterviewStatus(
    BuildContext context,
    InterviewStatusRequest status,
    int id,
  ) async {
    try {
      context.loaderOverlay.show();
      Future.delayed(const Duration(seconds: 2));

      final response = await apiClient.updateInterviewStatus(
        id,
        status,
        token!,
      );

      if (response.isSuccess) {
        showSnackBarSuccess(
          "success_title".tr,
          response.details.message ?? "interview_status_sent_successfully".tr,
        );
      } else {
        showSnackBarError(
          "failed_title".tr,
          response.details.message ?? "failed_to_send_interview_status".tr,
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }
}
