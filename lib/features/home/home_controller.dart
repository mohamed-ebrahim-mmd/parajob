import 'dart:developer';

import 'package:flutter/material.dart'
    show
        BuildContext,
        GlobalKey,
        WidgetsBinding,
        TextStyle,
        Colors,
        MainAxisAlignment;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/ui_components/auth_required_dialog.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeController extends GetxController {
  final _userController = Get.find<UserController>();
  late final _profileController = _userController.isGuest
      ? null
      : Get.find<ProfileController>();
  var homeCallState = ApiCallState.loading.obs;
  HomeResponse? homeData;
  /////
  ///
  final firstKey = GlobalKey();
  final secondKey = GlobalKey();
  final thirdKey = GlobalKey();

  final currentStep = 0.obs;
  late List<GlobalKey> keys;

  @override
  void onInit() {
    super.onInit();
    fetchHomeJobs();

    // startShowcase();
  }

  void startShowcase() {
    ShowcaseView.register(
      enableAutoScroll: true,

      // hideFloatingActionWidgetForShowcase: [thirdKey],
      onStart: (index, key) {},
      onComplete: (index, key) {
        if (index == 2) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light.copyWith(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
            ),
          );
        }
      },
      blurValue: 1,
      autoPlayDelay: const Duration(seconds: 3),
      globalTooltipActionConfig: const TooltipActionConfig(
        position: TooltipActionPosition.inside,
        alignment: MainAxisAlignment.spaceBetween,
        actionGap: 20,
      ),
      globalTooltipActions: [
        // Here we don't need previous action for the first showcase widget
        // so we hide this action for the first showcase widget
        TooltipActionButton(
          backgroundColor: Colors.transparent,
          type: TooltipDefaultActionType.previous,
          textStyle: const TextStyle(color: AppColors.pureWhite),
          hideActionWidgetForShowcase: [firstKey],
        ),
        // Here we don't need next action for the last showcase widget so we
        // hide this action for the last showcase widget
        TooltipActionButton(
          backgroundColor: Colors.transparent,
          type: TooltipDefaultActionType.next,
          textStyle: const TextStyle(color: AppColors.pureWhite),
          hideActionWidgetForShowcase: [thirdKey],
        ),
      ],
      onDismiss: (key) {
        //  debugPrint('Dismissed at $key');
      },
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ShowcaseView.get().startShowCase([firstKey, secondKey, thirdKey]),
    );
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
