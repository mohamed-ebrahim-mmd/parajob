import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/api_client/src/models/responses/skill.dart';
import 'package:para_job/packages/api_client/src/models/responses/skill_response.dart';
import 'package:para_job/packages/api_client/src/service/api_client_instance.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart'
    show Routes;
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

class CreateAccountSkillsController extends GetxController {
  final skillsCallState = ApiCallState.loading.obs;
  List<DropdownMenuEntry<int>> skillsMenu = [];
  List<Skill>? allSkillsList;
  final selectedSkillsList = <Skill>[].obs;

  List<int> get selectedSkillIds =>
      selectedSkillsList.map((s) => s.id).toList();

  @override
  void onInit() {
    super.onInit();
    fetchSkills();
  }

  void onSkillSelected(int? value) {
    if (value == null) return;

    final skill = getSkillById(value);
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
        skillsCallState.value = ApiCallState.success;
      } else {
        skillsCallState.value = ApiCallState.failure;
        showSnackBarError('failed'.tr, 'skills_fetch_failed'.tr);
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      skillsCallState.value = ApiCallState.failure;
      showSnackBarError('failed'.tr, 'skills_fetch_failed'.tr);
    }
  }

  List<DropdownMenuEntry<int>> getMenuSkills(List<Skill> skills) {
    return skills
        .map(
          (skill) =>
              DropdownMenuEntry<int>(value: skill.id, label: skill.name),
        )
        .toList();
  }

  void validateAndContinue() async {
    if (selectedSkillsList.isEmpty) {
      showSnackBarError('failed'.tr, 'select_at_least_one_skill'.tr);
      return;
    }
    Get.toNamed(
      "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}${Routes.createAccountFrontID}${Routes.createAccountBackID}${Routes.createAccountPicWithID}${Routes.educationInfo}${Routes.educationPic}${Routes.createAccountSkills}${Routes.createAccountCv}",
    );
  }
}
