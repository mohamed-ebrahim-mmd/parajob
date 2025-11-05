/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-16 9:51 AM
 ==================================================================
*/
import 'dart:developer';

import 'package:flutter/material.dart' show BuildContext;
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/ui_components/auth_required_dialog.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class HomeController extends GetxController {
  final userController = Get.find<UserController>();
  var homeCallState = ApiCallState.loading.obs;
  HomeResponse? homeData;

  @override
  void onInit() {
    super.onInit();
    fetchHomeJobs();
  }

  Future<void> fetchHomeJobs() async {
    homeCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchHomeJobs(
        userController.isGuest ? null : userController.token!,
      );

      if (response.isSuccess) {
        homeData = response;

        homeCallState.value = ApiCallState.success;
      } else {
        homeCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("🟢 ${e.toString()}");
      homeCallState.value = ApiCallState.failure;
    }
  }

  /// 🔖 Add bookmark
  Future<void> addBookmark(int jobId) async {
    try {
      final response = await apiClient.addBookmark(
        BookmarkRequest(jobId: jobId),
        userController.token!,
      );

      if (response.isSuccess) {
        showSnackBarSuccess(
          "Success",
          response.details?.message ?? "Job bookmarked successfully!",
        );
        fetchHomeJobs();
      } else {
        log("🔴 addBookmark ${response.details!.message}");

        showSnackBarError(
          "Failed",
          response.details?.message ?? "Could not bookmark the job.",
        );
      }
    } catch (e) {
      showSnackBarApiError();
    }
  }

  /// ❌ Remove bookmark
  Future<void> removeBookmark(int jobId) async {
    try {
      final response = await apiClient.deleteBookmark(
        BookmarkRequest(jobId: jobId),
        userController.token!,
      );

      if (response.isSuccess) {
        showSnackBarSuccess(
          "Success",
          response.details?.message ?? "Job removed from bookmarks.",
        );
        fetchHomeJobs();
      } else {
        log("🔴 removeBookmark ${response.details!.message}");
        showSnackBarError(
          "Failed",
          response.details?.message ?? "Could not remove bookmark.",
        );
      }
    } catch (e) {
      showSnackBarApiError();
    }
  }

  Future<void> handleBookmarkTap(Job job, BuildContext context) async {
    log("🟢 ${job.id}");
    log("🟢 ${job.isBookmark}");

    // 🔒 1. Check if the user is guest
    if (userController.isGuest) {
      showAuthRequiredDialog();
      return;
    }

    context.loaderOverlay.show();
    try {
      if (job.isBookmark!) {
        await removeBookmark(job.id!);
      } else {
        await addBookmark(job.id!);
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }
}
