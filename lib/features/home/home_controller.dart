import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Colors,
        GlobalKey,
        MainAxisAlignment,
        TextStyle,
        WidgetsBinding;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';

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
  final box = GetStorage();

  bool get hasSeenShowcase => box.read('hasSeenShowcase') ?? false;

  final firstKey = GlobalKey();
  final secondKey = GlobalKey();
  final thirdKey = GlobalKey();
  final lastKey = GlobalKey();

  final AppLinks _appLinks = AppLinks();

  @override
  void onInit() {
    super.onInit();

    fetchHomeJobs();

    if (Get.arguments == true) {
      _handleDeepLink();
    }
  }

  void _handleDeepLink() async {
    log("handleDeepLink called");

    // 1) Get the initial deep link
    final Uri? uri = await _appLinks.getInitialLink();
    if (uri == null) return;

    // 2) Extract jobId from /share/{id}
    String? jobIdString;
    if (uri.path.contains('/share/')) {
      final segments = uri.pathSegments;
      final shareIndex = segments.indexOf('share');
      if (shareIndex != -1 && shareIndex + 1 < segments.length) {
        jobIdString = segments[shareIndex + 1];
      }
    }

    // 3) Convert to int
    final int? jobId = int.tryParse(jobIdString ?? "");
    if (jobId == null) return;

    // 4) Navigate to job details
    Get.toNamed(Routes.jobDetails, arguments: jobId);
  }

  void startShowcase() {
    ShowcaseView.register(
      enableAutoScroll: true,
      onDismiss: (key) async {
        // Mark as seen when dismissed
        await box.write('hasSeenShowcase', true);
      },

      onFinish: () async {
        // Mark as seen when finished
        await box.write('hasSeenShowcase', true);
      },

      blurValue: 1,

      globalTooltipActionConfig: const TooltipActionConfig(
        position: TooltipActionPosition.inside,
        alignment: MainAxisAlignment.spaceBetween,
        actionGap: 20,
      ),
      globalTooltipActions: [
        TooltipActionButton(
          name: "Back",
          backgroundColor: Colors.transparent,
          type: TooltipDefaultActionType.previous,
          textStyle: const TextStyle(color: AppColors.pureWhite),
          hideActionWidgetForShowcase: [firstKey, secondKey],
        ),
        // for presrntation ui only
        TooltipActionButton(
          name: "",
          onTap: () {},
          backgroundColor: Colors.transparent,
          type: TooltipDefaultActionType.previous,
          textStyle: const TextStyle(color: AppColors.pureWhite),
          hideActionWidgetForShowcase: [firstKey, thirdKey, lastKey],
        ),

        TooltipActionButton(
          name: "Done",
          backgroundColor: Colors.transparent,
          type: TooltipDefaultActionType.next,
          textStyle: const TextStyle(color: AppColors.pureWhite),
          hideActionWidgetForShowcase: [firstKey, secondKey, thirdKey],
        ),
        // Here we don't need next action for the last showcase widget so we
        // hide this action for the last showcase widget
        TooltipActionButton(
          name: "Next",
          backgroundColor: Colors.transparent,
          type: TooltipDefaultActionType.next,
          textStyle: const TextStyle(color: AppColors.pureWhite),
          hideActionWidgetForShowcase: [firstKey, lastKey],
        ),
      ],
    );
    if (!hasSeenShowcase) {
      _goStart();
    }
  }

  _goStart() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ShowcaseView.get().startShowCase([
        firstKey,
        secondKey,
        thirdKey,
        lastKey,
      ]),
    );
  }

  goNext() {
    ShowcaseView.get().next();
  }

  goDismiss() {
    ShowcaseView.get().dismiss();
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

        startShowcase();
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

  @override
  void onClose() {
    ShowcaseView.get().unregister();
    super.onClose();
  }
}
