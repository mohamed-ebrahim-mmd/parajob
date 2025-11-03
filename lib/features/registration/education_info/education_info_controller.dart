/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 03/11/2025 1:43 PM
 ==================================================================
*/

import 'package:flutter/material.dart' show DropdownMenuEntry, showDatePicker;
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart'
    show Routes;
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart'
    show showSnackBarError;

class EducationInfoController extends GetxController {
  final universitiesCallState = ApiCallState.loading.obs;
  final facultiesCallState = DataFetchState.initial.obs;
  final selectedUniversityId = Rx<int?>(null);
  int? selectedFacultyId;
  final graduationYear = ''.obs;

  List<DropdownMenuEntry<int>> universityMenuEntries = [];
  List<DropdownMenuEntry<int>> facultyMenuEntries = [];

  @override
  void onInit() {
    super.onInit();
    fetchUniversities();
  }

  /// 🎓 Fetch all universities
  Future<void> fetchUniversities() async {
    universitiesCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.getUniversities();
      if (response.isSuccess) {
        universityMenuEntries = response.data
            .map((u) => DropdownMenuEntry<int>(value: u.id, label: u.name))
            .toList();
        universitiesCallState.value = ApiCallState.success;
      } else {
        universitiesCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      universitiesCallState.value = ApiCallState.failure;
    }
  }

  /// 🏫 Handle university selection
  void onUniversitySelected(int? universityId) {
    if (universityId != null && universityId != selectedUniversityId.value) {
      selectedUniversityId.value = universityId;
      selectedFacultyId = null;
      fetchFaculties(universityId);
    }
  }

  /// 📚 Fetch faculties by university
  Future<void> fetchFaculties(int universityId) async {
    facultiesCallState.value = DataFetchState.loading;

    try {
      final response = await apiClient.getFacultiesByUniversity(universityId);
      if (response.isSuccess) {
        facultyMenuEntries = response.data
            .map((f) => DropdownMenuEntry<int>(value: f.id, label: f.name))
            .toList();
        facultiesCallState.value = DataFetchState.success;
      } else {
        facultiesCallState.value = DataFetchState.failure;
      }
    } catch (e) {
      facultiesCallState.value = DataFetchState.failure;
    }
  }

  Future<void> pickGraduationYear() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
      helpText: 'Select your graduation year',
    );

    if (pickedDate != null) {
      graduationYear.value = pickedDate.year.toString();
    }
  }

  /// ✅ Validate before proceeding
  void onSubmitEducationInfo() {
    if (selectedUniversityId.value == null) {
      showSnackBarError("Failed", "Please select a university");
      return;
    }

    if (selectedFacultyId == null) {
      showSnackBarError("Failed", "Please select a faculty");
      return;
    }

    if (graduationYear.value.isEmpty) {
      showSnackBarError("Failed", "Please select your graduation year");
      return;
    }

    // 🚀 Continue to next step
    Get.toNamed(
      "${Routes.createAccount}"
      "${Routes.createAccountOTP}"
      "${Routes.createAccountSetPass}"
      "${Routes.createAccountFrontID}"
      "${Routes.createAccountBackID}"
      "${Routes.createAccountPicWithID}"
      "${Routes.educationInfo}"
      "${Routes.educationPic}",
    );
  }
}
