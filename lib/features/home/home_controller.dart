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
  var isRefreshing = false.obs; //  track refresh state
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

  Future<void> fetchHomeJobs({bool isRefresh = false}) async {
    // Set refresh state if this is a refresh operation
    if (isRefresh) {
      isRefreshing.value = true;
    } else {
      homeCallState.value = ApiCallState.loading;
    }

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
    } finally {
      // Reset refresh state
      if (isRefresh) {
        isRefreshing.value = false;
      }
    }
  }

  Future<void> _addBookmark(Job job) async {
    try {
      final response = await apiClient.addBookmark(
        BookmarkRequest(jobId: job.id!),
        _userController.token!,
      );

      if (response.isSuccess) {
        showSnackBarSuccess(
          "success_title".tr,
          response.details?.message ?? "job_bookmarked_success".tr,
        );
        job.isBookmarkedReactive.value = true;
        _profileController!.fetchProfileDetails();
      } else {
        log("🔴 addBookmark ${response.details!.message}");
        showSnackBarError(
          "failed_title".tr,
          response.details?.message ?? "job_bookmark_failed".tr,
        );
      }
    } catch (e) {
      showSnackBarApiError();
    }
  }

  Future<void> _removeBookmark(Job job) async {
    try {
      final response = await apiClient.deleteBookmark(
        BookmarkRequest(jobId: job.id!),
        _userController.token!,
      );

      if (response.isSuccess) {
        showSnackBarSuccess(
          "success_title".tr,
          response.details?.message ?? "job_removed_from_bookmarks".tr,
        );
        job.isBookmarkedReactive.value = false;
        _profileController!.fetchProfileDetails();
      } else {
        log("🔴 removeBookmark ${response.details!.message}");
        showSnackBarError(
          "failed_title".tr,
          response.details?.message ?? "job_remove_bookmark_failed".tr,
        );
      }
    } catch (e) {
      showSnackBarApiError();
    }
  }

  Future<void> handleBookmarkTap(Job job, BuildContext context) async {
    if (_userController.isGuest) {
      showAuthRequiredDialog();
      return;
    }

    context.loaderOverlay.show();
    try {
      if (job.isBookmarkedReactive.value) {
        await _removeBookmark(job);
        job.isBookmarkedReactive.value = false;
      } else {
        await _addBookmark(job);
        job.isBookmarkedReactive.value = true;
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }
}
