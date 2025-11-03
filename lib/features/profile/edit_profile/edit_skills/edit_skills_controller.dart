import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/api_client/src/models/requests/edit_user_request.dart';
import 'package:para_job/packages/api_client/src/models/responses/skill.dart';
import 'package:para_job/packages/api_client/src/models/responses/skill_response.dart';
import 'package:para_job/packages/api_client/src/service/api_client_instance.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class EditSkillsController extends GetxController {
  final String token = Get.find<UserController>().token!;
  final BuildContext screenContext;
  EditSkillsController({required this.screenContext});

  final skillsCallState = ApiCallState.loading.obs;
  List<DropdownMenuEntry<int>> skillsMenu = [];

  List<Skill>? allSkillsList;
  final selectedSkillsList = <Skill>[].obs;
  @override
  void onInit() {
    super.onInit();
    fechSkills();
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

  Future<void> fechSkills() async {
    skillsCallState.value = ApiCallState.loading;

    try {
      final SkillResponse skillsResponse = await apiClient.getSkills();

      if (skillsResponse.isSuccess) {

          allSkillsList = skillsResponse.data;
        skillsMenu = getmenuSkills(skillsResponse.data);
        selectedSkillsList.value = Get.find<ProfileController>().profileData?.skills??[];


        skillsCallState.value = ApiCallState.success;
      } else {
        skillsCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      skillsCallState.value = ApiCallState.failure;
    }
  }

  List<DropdownMenuEntry<int>> getmenuSkills(List<Skill> skills) {
    return skills
        .map(
          (skill) => DropdownMenuEntry<int>(value: skill.id, label: skill.name),
        )
        .toList();
  }



  Future<void> editUserProfile(
   
  ) async {
    screenContext.loaderOverlay.show();
    try {
      final response = await apiClient.updateUserProfile(EditUserRequest(skills: selectedSkillsList.map((s) => s.id).toList()), token);

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




}
