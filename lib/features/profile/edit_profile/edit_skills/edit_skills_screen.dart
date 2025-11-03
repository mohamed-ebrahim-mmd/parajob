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
                  labelText: "Loading skills...",
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
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
                    hintText: "Choose skill",
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
                    decoration: const InputDecoration(
                      labelText: "Failed to load, tap to retry",
                      suffixIcon: Icon(Icons.refresh),
                    ),
                  ),
                ),
              );
          }
        }),
        Spacer(),
        FilledButton(
          onPressed: controller.editUserProfile,
          child: Text("Save changes"),
        ),
        context.hBox(2.5),
      ],
    );
  }
}
