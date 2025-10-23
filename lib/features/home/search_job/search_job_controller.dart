/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-23 11:49 AM
 ==================================================================
*/
import 'package:flutter/material.dart' show DropdownMenuEntry;
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';

class SearchJobController extends GetxController {
  // Unified call state
  final searchDataCallState = ApiCallState.loading.obs;
  int? selectedSkillId;
  int? selectedCompanyId;
  String? selectedJobType;
  String? selectedJobCategory;
  // Data
  List<Skill> skills = [];
  List<CompanyListItem> companies = [];

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
    fetchSearchData();
  }

  Future<void> fetchSearchData() async {
    searchDataCallState.value = ApiCallState.loading;

    try {
      final results = await Future.wait([
        apiClient.getSkills(),
        apiClient.getCompanies(),
      ]);

      final skillsResponse = results[0] as SkillResponse;
      final companiesResponse = results[1] as CompanyListResponse;

      if (skillsResponse.isSuccess && companiesResponse.isSuccess) {
        skills = skillsResponse.data;
        companies = companiesResponse.data;
        searchDataCallState.value = ApiCallState.success;
      } else {
        searchDataCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      searchDataCallState.value = ApiCallState.failure;
    }
  }
}
