//
//  @ Header: @Author: mary.mark@moselaymd.com |

import 'dart:developer';

import 'package:flutter/material.dart' show BuildContext;
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/home/home_controller.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class BookmarkedJobsController extends GetxController {
  /// Paging controller for infinite scroll pagination
  late final PagingController<int, Job> pagingController;

  /// Authentication token retrieved from user controller
  final String token = Get.find<UserController>().token!;

  final _homeController = Get.find<HomeController>();
  final _profileController = Get.find<ProfileController>();

  @override
  void onInit() {
    super.onInit();
    initPagingController();
  }

  /// Initialize pagination logic
  void initPagingController() {
    pagingController = PagingController<int, Job>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: _fetchBookmarkPage,
    );
  }

  /// Fetches bookmarked jobs from API (single page)
  Future<List<Job>> _fetchBookmarkPage(int pageKey) async {
    log('📄 Fetching bookmarked jobs (page: $pageKey)');

    final response = await apiClient.fetchBookmark(token: token, page: pageKey);

    if (response.isSuccess) {
      return response.data ?? [];
    } else {
      throw Exception('Failed to fetch jobs');
    }
  }

  Future<void> removeBookmark(int jobId, BuildContext context) async {
    try {
      context.loaderOverlay.show();
      final response = await apiClient.deleteBookmark(
        BookmarkRequest(jobId: jobId),
        token,
      );

      if (response.isSuccess) {
        if (_homeController.jobIsInHome(jobId)) {
          _homeController.fetchHomeJobs();
        }
        if (_profileController.jobIsInSavedJobs(jobId)) {
          _profileController.fetchProfileDetails();
        }

        final newState = pagingController.value.filterItems(
          (job) => job.id != jobId,
        );
        pagingController.value = newState;
        showSnackBarSuccess(
          "success_title".tr,
          response.details?.message ?? "job_removed_bookmark".tr,
        );
      } else {
        log("🔴 removeBookmark ${response.details!.message}");
        showSnackBarError(
          "failed_title".tr,
          response.details?.message ?? "job_could_not_remove".tr,
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
    pagingController.dispose();
    super.onClose();
  }
}
