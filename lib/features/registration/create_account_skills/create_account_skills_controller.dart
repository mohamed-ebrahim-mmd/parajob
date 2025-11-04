import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/api_client/src/models/responses/skill.dart';
import 'package:para_job/packages/api_client/src/models/responses/skill_response.dart';
import 'package:para_job/packages/api_client/src/service/api_client_instance.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

class CreateAccountSkillsController extends GetxController {
  final skillsCallState = ApiCallState.loading.obs;
  List<DropdownMenuEntry<int>> skillsMenu = [];
  List<Skill>? allSkillsList;
  final selectedSkillsList = <Skill>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSkills();
  }

  void onSkillSelected(int? value) {
    if (value == null) return;

    // Get the skill object from the full list
    final skill = getSkillById(value);

    // Only add if not already in the selected list
    final alreadySelected = selectedSkillsList.any((s) => s.id == skill.id);

    if (!alreadySelected) {
      selectedSkillsList.add(skill);
    }
  }

  Skill getSkillById(int skillId) {
    return allSkillsList!.firstWhere((skill) => skill.id == skillId);
  }

  Future<void> fetchSkills() async {
    skillsCallState.value = ApiCallState.loading;

    try {
      final SkillResponse skillsResponse = await apiClient.getSkills();

      if (skillsResponse.isSuccess) {
        allSkillsList = skillsResponse.data;
        skillsMenu = getMenuSkills(skillsResponse.data);
        selectedSkillsList.value =
            Get.find<ProfileController>().profileData?.skills ?? [];

        skillsCallState.value = ApiCallState.success;
      } else {
        skillsCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      skillsCallState.value = ApiCallState.failure;
    }
  }

  List<DropdownMenuEntry<int>> getMenuSkills(List<Skill> skills) {
    return skills
        .map(
          (skill) => DropdownMenuEntry<int>(value: skill.id, label: skill.name),
        )
        .toList();
  }

  void editUser() async {
    //
    if (selectedSkillsList.isEmpty) {
      showSnackBarError("Failed", 'Please select at least one skill');
      return;
    }
    showSnackBarSuccess("Success", "Skills selected successfully");
    // await editUserProfile();
  }

  /*
  Future<void> editUserProfile() async {
    screenContext.loaderOverlay.show();
    try {
      final response = await apiClient.updateUserProfile(
        EditUserRequest(skills: selectedSkillsList.map((s) => s.id).toList()),
        token,
      );

      if (response.isSuccess) {
        log("🟢 isSuccess");
        showSnackBarSuccess(
          "success",
          response.details.message ?? "edit successfully",
        );
      } else {
        showSnackBarError("Failed", response.details.message ?? "edit failed");
        log(response.details.message ?? "edit failed");
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      showSnackBarError("Failed", e.toString());
    } finally {
      screenContext.loaderOverlay.hide();
    }
  }
*/
}
