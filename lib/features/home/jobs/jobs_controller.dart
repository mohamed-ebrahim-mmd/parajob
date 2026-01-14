import 'dart:developer';

import 'package:flutter/material.dart' show BuildContext;
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/home/home_controller.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/ui_components/auth_required_dialog.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class JobsController extends GetxController {
  final _userController = Get.find<UserController>();
  final _homeController = Get.find<HomeController>();
  late final _profileController = _userController.isGuest
      ? null
      : Get.find<ProfileController>();
  var departmentCallState = ApiCallState.loading.obs;
  var selectedDepartmentId = (-1).obs;

  List<Department>? departments;
  final String jobCategory;
  late final PagingController<int, Job> pagingController;
  final int depId;

  JobsController({required this.jobCategory, required this.depId});

  @override
  void onInit() {
    super.onInit();
    fetchDepartments();
    selectedDepartmentId.value = depId;
  }

  void selectDepartment(int id) {
    if (selectedDepartmentId.value != id) {
      selectedDepartmentId.value = id;
      pagingController.refresh();
    }
  }

  Future<void> fetchDepartments() async {
    departmentCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.getDepartments();

      if (response.isSuccess ?? false) {
        departments = response.data;
        departments?.insert(0, Department(id: -1, name: "all".tr));
        _initPagingController();
        departmentCallState.value = ApiCallState.success;
      } else {
        departmentCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      departmentCallState.value = ApiCallState.failure;
    }
  }

  void _initPagingController() {
    pagingController = PagingController<int, Job>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) async {
        final response = await apiClient.fetchJobs(
          page: pageKey,
          category: jobCategory,
          departmentId: selectedDepartmentId.value == -1
              ? null
              : selectedDepartmentId.value,
          token: _userController.isGuest ? null : _userController.token!,
        );

        if (response.isSuccess ?? false) {
          return response.data ?? [];
        } else {
          log(
            '🔴 failed_fetch_jobs_for_department: ${selectedDepartmentId.value}',
          );
          throw Exception('Failed to load jobs');
        }
      },
    );
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
            return job.copyWith(isBookmark: true);
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
            return job.copyWith(isBookmark: false);
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

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
