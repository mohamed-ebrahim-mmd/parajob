import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/ui_components/auth_required_dialog.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void handleApplyJobPressed() {
    if (user.isGuest) {
      showAuthRequiredDialog();
    } else {
      Get.toNamed(
        "${Routes.jobDetails}${Routes.applyJob}",
        arguments: jobData!.data.id,
      );
    }
  }

  Future<void> fetchJobDetails(int id) async {
    jobDetailsCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchJobDetails(
        id: id,
        token: user.token,
      );
      if (response.isSuccess) {
        log("🟢 isSuccess");
        jobData = response;
        jobDetailsCallState.value = ApiCallState.success;
      } else {
        jobDetailsCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
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
        showSnackBarJobApplicationCongrats();
        fetchJobDetails(jobId);
        Get.until((route) => Get.currentRoute == Routes.jobDetails);
      } else {
        showSnackBarError(
          "failed_title".tr,
          response.details?.message ?? "unknown_error".tr,
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }

  Future<void> withDrawJob(BuildContext context, int applicationId) async {
    try {
      Get.back();
      context.loaderOverlay.show();

      final response = await apiClient.withdrawJob(
        token: user.token!,
        applicationId: applicationId,
      );

      if (response.isSuccess) {
        fetchJobDetails(jobId);
      } else {
        showSnackBarError(
          "failed_title".tr,
          response.details?.message ?? "unknown_error".tr,
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }

  //change DataFormate

  String formatLocalizedDate(String dateString) {
    final date = DateTime.tryParse(dateString);
    if (date == null) return dateString;

    // Get current locale from GetX
    final locale = Get.locale?.languageCode ?? "en";

    // Format: 9 مارس / 9 March
    final formatter = DateFormat("d MMMM", locale);

    return formatter.format(date);
  }

  //change TimeFormate

  String formatLocalizedTime(String? time) {
    if (time == null || time.isEmpty) return "-";

    // time comes like "07:00" or "17:00"
    final parsed = DateTime.tryParse("2025-01-01 $time");
    if (parsed == null) return "-";

    final isArabic = Get.locale?.languageCode == "ar";

    if (isArabic) {
      // Arabic format
      final hour = parsed.hour % 12 == 0 ? 12 : parsed.hour % 12;
      final suffix = parsed.hour >= 12 ? "م" : "ص";
      return "$hour $suffix";
    } else {
      // English format
      return DateFormat("h a", "en").format(parsed);
    }
  }

  Future<void> openLocation() async {
    try {
      final uri = Uri.parse(jobData?.data.locationLink ?? "");
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        Get.snackbar('location_error'.tr, 'location_failed_to_open'.tr);
      }
    } catch (e) {
      log('Error opening location: $e');
      Get.snackbar('location_error'.tr, 'location_failed_to_open'.tr);
    }
  }

  Future<void> shareJob(JobData job) async {
    final jobTitle = job.title;
    final companyName = job.company.name;
    final jobDescription = job.description;
    final jobLink = job.shareableLink;

    final message =
        '''
Check out this job: $jobTitle
Company: $companyName
Description: $jobDescription
Job link: $jobLink
Job ID: ${job.id}
''';

    try {
      // Share the job info including the link
      await Share.share(message, subject: 'Share Job: $jobTitle');
    } catch (e) {
      showSnackBarError('share_error'.tr, 'failed_to_share_job'.tr);
    }
  }
}
