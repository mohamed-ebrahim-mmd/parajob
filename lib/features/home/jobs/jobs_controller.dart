/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-22 10:43 AM
 ==================================================================
*/

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
  var selectedDepartmentId = (-1).obs; // For the selected button
  List<Department>? departments;
  final String jobCategory;
  late final pagingController;

  JobsController({required this.jobCategory});

  @override
  void onInit() {
    super.onInit();
    fetchDepartments();
  }

  /// Change selected department
  void selectDepartment(int id) {
    if (selectedDepartmentId.value != id) {
      selectedDepartmentId.value = id;
      pagingController.refresh();
    }
  }

  /// Fetch departments first, then initialize paging
  Future<void> fetchDepartments() async {
    departmentCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.getDepartments();

      if (response.isSuccess ?? false) {
        //add the "All" department at the beginning of the list
        departments = response.data;
        departments?.insert(0, Department(id: -1, name: "All"));
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

  /// Initialize pagination logic (runs only after departments are loaded)
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
            '🔴 Failed to fetch jobs for department: ${selectedDepartmentId.value}',
          );
          throw Exception('Failed to fetch jobs');
        }
      },
    );
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
        pagingController.refresh();
        if (_homeController.jobIsInHome(jobId)) {
          _homeController.fetchHomeJobs();
        }
        _profileController?.fetchProfileDetails();
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
        pagingController.refresh();
        if (_homeController.jobIsInHome(jobId)) {
          _homeController.fetchHomeJobs();
        }
        _profileController?.fetchProfileDetails();
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

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
