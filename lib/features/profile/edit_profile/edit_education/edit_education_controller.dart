import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/api_client/src/models/requests/edit_user_request.dart';
import 'package:para_job/packages/api_client/src/service/api_client_instance.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class EditEducationController extends GetxController {
  final BuildContext screenContext;

  EditEducationController(this.screenContext);

  final graduationYearController = TextEditingController();
  final profileController = Get.find<ProfileController>();
  late final user = profileController.profileData;
  final String token = Get.find<UserController>().token!;

  final facultiesCallState = ApiCallState.loading.obs;
  List<DropdownMenuEntry<int>> facultyMenuEntries = [];
  int? selectedFacultyId;

  @override
  void onInit() {
    super.onInit();
    setInitialData();
    fetchFaculties(user!.university!);
  }

  void setInitialData() {
    graduationYearController.text = user!.graduationYear ?? "-";
    selectedFacultyId = user!.faculty;
  }

  void onFacultySelected(int? value) {
    if (value != null && value != selectedFacultyId) {
      selectedFacultyId = value;
    }
  }

  Future<void> pickGraduationYear() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(
        int.tryParse(graduationYearController.text) ?? 2000,
      ),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
      helpText: 'select_graduation_year'.tr,
    );

    if (pickedDate != null) {
      graduationYearController.text = pickedDate.year.toString();
    }
  }

  /// 📚 Fetch faculties by university
  Future<void> fetchFaculties(int universityId) async {
    facultiesCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.getFacultiesByUniversity(universityId);
      if (response.isSuccess) {
        facultyMenuEntries = response.data
            .map((f) => DropdownMenuEntry<int>(value: f.id, label: f.name))
            .toList();
        facultiesCallState.value = ApiCallState.success;
      } else {
        facultiesCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      facultiesCallState.value = ApiCallState.failure;
    }
  }

  void editUser() async {
    if (graduationYearController.text.isEmpty) {
      showSnackBarError("failed_title".tr, 'select_graduation_year_msg'.tr);
      return;
    }

    if (selectedFacultyId == null) {
      showSnackBarError("failed_title".tr, 'select_faculty_msg'.tr);
      return;
    }

    await editUserProfile();
  }

  Future<void> editUserProfile() async {
    screenContext.loaderOverlay.show();
    try {
      final response = await apiClient.updateUserProfile(
        EditUserRequest(
          graduationYear: int.tryParse(graduationYearController.text),
          facultyId: selectedFacultyId,
        ),
        token,
      );

      if (response.isSuccess) {
        await profileController.fetchProfileDetails();
        log("🟢 isSuccess");
        showSnackBarSuccess(
          "success_title".tr,
          response.details.message ?? "edit_successfully".tr,
        );
      } else {
        showSnackBarError(
          "failed_title".tr,
          response.details.message ?? "edit_failed".tr,
        );
        log(response.details.message ?? "edit_failed");
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      screenContext.loaderOverlay.hide();
    }
  }

  @override
  void onClose() {
    graduationYearController.dispose();
    super.onClose();
  }
}
