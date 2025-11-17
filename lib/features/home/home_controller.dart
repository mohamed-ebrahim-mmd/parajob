/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-16 9:51 AM
 ==================================================================
*/
import 'dart:developer';

import 'package:flutter/material.dart' show BuildContext;
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/ui_components/auth_required_dialog.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class HomeController extends GetxController {
  final _userController = Get.find<UserController>();
  late final _profileController = _userController.isGuest
      ? null
      : Get.find<ProfileController>();
  var homeCallState = ApiCallState.loading.obs;
  HomeResponse? homeData;

  @override
  void onInit() {
    super.onInit();
    fetchHomeJobs();
  }

  bool jobIsInHome(int id) {
    final jobCategoriesList = homeData?.data.first;

    if (jobCategoriesList == null) return false;

    final hotJobs = jobCategoriesList.hotJobs;
    final flexJobs = jobCategoriesList.flexibleJobs;
    final nonFlexJobs = jobCategoriesList.nonFlexibleJobs;

    final isFound =
        hotJobs.any((job) => job.id == id) ||
        flexJobs.any((job) => job.id == id) ||
        nonFlexJobs.any((job) => job.id == id);

    return isFound;
  }

  Future<void> fetchHomeJobs() async {
    homeCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchHomeJobs(
        _userController.isGuest ? null : _userController.token!,
      );

      if (response.isSuccess) {
        log("🟢 fetchHomeJobs success");
        homeData = response;
        homeCallState.value = ApiCallState.success;
      } else {
        homeCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      homeCallState.value = ApiCallState.failure;
    }
  }

  /// 🔖 Add bookmark
  Future<void> _addBookmark(int jobId) async {
    try {
      final response = await apiClient.addBookmark(
        BookmarkRequest(jobId: jobId),
        _userController.token!,
      );

      if (response.isSuccess) {
        showSnackBarSuccess(
          "Success",
          response.details?.message ?? "Job bookmarked successfully!",
        );
        fetchHomeJobs();
        _profileController!.fetchProfileDetails();
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
  Future<void> _removeBookmark(int jobId) async {
    try {
      final response = await apiClient.deleteBookmark(
        BookmarkRequest(jobId: jobId),
        _userController.token!,
      );

      if (response.isSuccess) {
        showSnackBarSuccess(
          "Success",
          response.details?.message ?? "Job removed from bookmarks.",
        );
        fetchHomeJobs();
        _profileController!.fetchProfileDetails();
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
    // 🔒 1. Check if the user is guest
    if (_userController.isGuest) {
      showAuthRequiredDialog();
      return;
    }

    context.loaderOverlay.show();
    try {
      if (job.isBookmark!) {
        await _removeBookmark(job.id!);
      } else {
        await _addBookmark(job.id!);
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }
}
