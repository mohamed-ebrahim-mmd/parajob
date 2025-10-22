/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-22 10:43 AM
 ==================================================================
*/

import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/packages/api_client/api_client.dart';

class JobsController extends GetxController {
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
        log("🟢 isSuccess");
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

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
