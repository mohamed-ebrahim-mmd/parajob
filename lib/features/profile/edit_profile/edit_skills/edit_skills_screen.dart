import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/edit_profile/edit_skills/edit_skills_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/skill_item.dart';

class EditSkillsScreen extends StatelessWidget {
  EditSkillsScreen({super.key, required this.screenContext});

  final BuildContext screenContext;
  late final controller = Get.put(
    EditSkillsController(screenContext: screenContext),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.hBox(2),
        Obx(() {
          switch (controller.skillsCallState.value) {
            case ApiCallState.loading:
              return TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'edit_skills_loading'.tr,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              );

            case ApiCallState.success:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownMenu<int>(
                    enableSearch: true,
                    expandedInsets: EdgeInsets.zero,
                    menuHeight: context.hPct(30),
                    hintText: 'edit_skills_hint'.tr,
                    onSelected: controller.onSkillSelected,
                    dropdownMenuEntries: controller.skillsMenu,
                  ),
                  context.hBox(1.5),
                  Wrap(
                    spacing: context.wPct(3),
                    runSpacing: context.wPct(3),
                    children: controller.selectedSkillsList
                        .map(
                          (skill) => SkillItem(
                            skill: skill.name,
                            onDelete: () {
                              controller.selectedSkillsList.remove(skill);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],
              );

            case ApiCallState.failure:
              return GestureDetector(
                onTap: controller.fetchSkills,
                child: AbsorbPointer(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'edit_skills_failed_load'.tr,
                      suffixIcon: const Icon(Icons.refresh),
                    ),
                  ),
                ),
              );
          }
        }),
        Spacer(),
        FilledButton(
          onPressed: controller.editUser,
          child: Text('edit_skills_save_button'.tr),
        ),
        context.hBox(2.5),
      ],
    );
  }
}
