//Mary Mark ||  mary.mark@moselaymd.com || Tue Dec 02 2025 17:10:28

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/api_client/src/enums/interview_status_enum.dart';
import 'package:para_job/packages/api_client/src/models/responses/job_interview_data.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class InterviewController extends GetxController {
  final token = Get.find<UserController>().token;
  InterviewData? interviewData;
  var interviewCallState = ApiCallState.loading.obs;
  final int id;

  InterviewController({required this.id});

  @override
  void onInit() {
    super.onInit();
    fetchInterviewData();
  }

  Future<void> fetchInterviewData() async {
    interviewCallState.value = ApiCallState.loading;
    try {
      final response = await apiClient.getInterviewDetails(
        jobId: id,
        token: token!,
      );

      if (response.isSuccess) {
        interviewData = response.data;
        interviewCallState.value = ApiCallState.success;
      } else {
        interviewCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      interviewCallState.value = ApiCallState.failure;
    }
  }

  Future<void> sendInterviewStatus(
    BuildContext context,
    InterviewStatusRequest status,
  ) async {
    try {
      context.loaderOverlay.show();

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
        fetchInterviewData();
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

  void sendAcceptedStatus(BuildContext context) {
    InterviewStatusRequest status = InterviewStatusRequest(
      userResponse: InterviewStatusEnum.accepted,
    );
    sendInterviewStatus(context, status);
  }

  void sendRejectedStatus(BuildContext context) {
    InterviewStatusRequest status = InterviewStatusRequest(
      userResponse: InterviewStatusEnum.rejected,
    );
    sendInterviewStatus(context, status);
  }

  String getModeText() {
    final mode = interviewData?.mode;
    if (mode == null) return "-";
    final modeMap = {
      'online': 'online'.tr,
      // In case 'offline' is returned from the backend, we handle it locally so it becomes Onsite
      'offline': 'onsite'.tr,
    };

    return modeMap[mode.toLowerCase()] ?? mode;
  }

  String getLinkOrLocationLabel() {
    final mode = interviewData?.mode?.toLowerCase();

    // Check if mode is explicitly offline
    if (mode == 'offline') {
      return "meeting_location".tr;
    }
    // Default to meeting link for online or null
    return "meeting_link".tr;
  }

  String getLinkOrLocationText() {
    final mode = interviewData?.mode?.toLowerCase();

    if (mode == 'offline') {
      return interviewData?.location ?? "-";
    }
    return interviewData?.meetingLink ?? "-";
  }

  void onLinkOrLocationTap() {
    final mode = interviewData?.mode?.toLowerCase();

    if (mode == 'offline') {
      // Logic to open Maps or handle location tap
      openLocation();
    } else {
      // Existing logic for online meeting
      openMeetingLink();
    }
  }

  Future<void> openLocation() async {
    final locationLink = interviewData?.location;
    try {
      final uri = Uri.parse(locationLink ?? "");
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        Get.snackbar('location_error'.tr, 'location_failed_to_open'.tr);
      }
    } catch (e) {
      Get.snackbar('location_error'.tr, 'location_failed_to_open'.tr);
    }
  }

  Future<void> openMeetingLink() async {
    try {
      final uri = Uri.parse(interviewData?.meetingLink ?? "");
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      showSnackBarError("invalid_link_title".tr, "invalid_meeting_link".tr);
    }
  }
}
