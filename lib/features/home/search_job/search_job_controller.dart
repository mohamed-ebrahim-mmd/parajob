/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-23 11:49 AM
 ==================================================================
*/
import 'package:flutter/cupertino.dart' show TextEditingController;
import 'package:flutter/material.dart' show DropdownMenuEntry;
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/packages/api_client/api_client.dart';

class SearchJobController extends GetxController {
  // Unified call state
  final searchDataCallState = ApiCallState.loading.obs;
  late final pagingController;
  final TextEditingController titleController = TextEditingController();

  int? selectedSkillId;
  int? selectedCompanyId;
  String? selectedJobType;
  String? selectedJobCategory;
  // Data
  List<DropdownMenuEntry<int>> skills = [];
  List<DropdownMenuEntry<int>> companies = [];

  final jobTypeMenuEntries = [
    DropdownMenuEntry<String>(value: 'part_time', label: 'Part time'),
    DropdownMenuEntry<String>(value: 'full_time', label: 'Full time'),
  ];

  final jobCategoriesEntries = [
    DropdownMenuEntry<String>(value: 'flexible', label: 'Flexible'),
    DropdownMenuEntry<String>(value: 'non_flexible', label: 'Non Flexible'),
    DropdownMenuEntry<String>(value: 'hot_job', label: 'Hot Job'),
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
          throw Exception('Failed to load jobs');
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

  void applyFilters() {
    // refresh the paging controller to reload jobs with the selected filters
    pagingController.refresh();

    // close the bottom sheet or dialog
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
