import 'dart:developer';

import 'package:flutter/cupertino.dart' show TextEditingController;
import 'package:flutter/material.dart' show DropdownMenuEntry;
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/home/home_controller.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/ui_components/auth_required_dialog.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class SearchJobController extends GetxController {
  final searchDataCallState = ApiCallState.loading.obs;
  late final PagingController<int, Job> pagingController;
  final TextEditingController titleController = TextEditingController();
  final _homeController = Get.find<HomeController>();
  late final _profileController = _userController.isGuest
      ? null
      : Get.find<ProfileController>();
  final _userController = Get.find<UserController>();

  int? selectedSkillId;
  int? selectedCompanyId;
  String? selectedJobType;
  String? selectedJobCategory;

  // Data
  List<DropdownMenuEntry<int>> skills = [];
  List<DropdownMenuEntry<int>> companies = [];

  final jobTypeMenuEntries = [
    DropdownMenuEntry<String>(value: 'part_time', label: 'part_time'.tr),
    DropdownMenuEntry<String>(value: 'full_time', label: 'full_time'.tr),
  ];

  final jobCategoriesEntries = [
    DropdownMenuEntry<String>(value: 'flexible', label: 'flexible_job'.tr),
    DropdownMenuEntry<String>(value: 'non_flexible', label: 'non_flexible_job'.tr),
    DropdownMenuEntry<String>(value: 'hot_job', label: 'hot_job'.tr),
  ];

  @override
  void onInit() {
    super.onInit();
    initializeSearchData();
  }

  Future<void> _initPagingController() async {
    pagingController = PagingController<int, Job>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) async {
        final response = await apiClient.fetchJobs(
          token: _userController.isGuest ? null : _userController.token!,
          page: pageKey,
          title: titleController.text.isNotEmpty
              ? titleController.text.trim()
              : null,
          companyId: selectedCompanyId,
          skillId: selectedSkillId,
          type: selectedJobType,
          category: selectedJobCategory,
        );
        if (response.isSuccess ?? false) {
          return response.data ?? [];
        } else {
          throw Exception("Failed to load jobs");
        }
      },
    );
  }

  Future<void> initializeSearchData() async {
    searchDataCallState.value = ApiCallState.loading;

    try {
      final results = await Future.wait([
        apiClient.getSkills(),
        apiClient.getCompanies(),
        _initPagingController(),
      ]);

      final skillsResponse = results[0] as SkillResponse;
      final companiesResponse = results[1] as CompanyListResponse;

      if (skillsResponse.isSuccess && companiesResponse.isSuccess) {
        skills = skillsResponse.data
            .map(
              (skill) =>
                  DropdownMenuEntry<int>(value: skill.id, label: skill.name),
            )
            .toList();

        companies = companiesResponse.data
            .map(
              (company) => DropdownMenuEntry<int>(
                value: company.id,
                label: company.name,
              ),
            )
            .toList();
        searchDataCallState.value = ApiCallState.success;
      } else {
        searchDataCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      searchDataCallState.value = ApiCallState.failure;
    }
  }

  Future<void> _addBookmark(int jobId) async {
    try {
      final response = await apiClient.addBookmark(
        BookmarkRequest(jobId: jobId),
        _userController.token!,
      );

      if (response.isSuccess) {
        showSnackBarSuccess(
          "success_title".tr,
          response.details?.message ?? "job_bookmarked_success".tr,
        );
        pagingController.mapItems((job) {
          if (job.id == jobId) {
            return job.copyWith(isBookmark: true); // or false for remove
          }
          return job;
        });

        if (_homeController.jobIsInHome(jobId)) {
          _homeController.fetchHomeJobs();
        }
        _profileController?.fetchProfileDetails();
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

  Future<void> _removeBookmark(int jobId) async {
    try {
      final response = await apiClient.deleteBookmark(
        BookmarkRequest(jobId: jobId),
        _userController.token!,
      );

      if (response.isSuccess) {
        showSnackBarSuccess(
          "success_title".tr,
          response.details?.message ?? "job_removed_from_bookmarks".tr,
        );
        pagingController.mapItems((job) {
          if (job.id == jobId) {
            return job.copyWith(isBookmark: false); // or false for remove
          }
          return job;
        });
        if (_homeController.jobIsInHome(jobId)) {
          _homeController.fetchHomeJobs();
        }
        _profileController?.fetchProfileDetails();
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

  void applyFilters() {
    pagingController.refresh();
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    pagingController.dispose();
    super.onClose();
  }
}
