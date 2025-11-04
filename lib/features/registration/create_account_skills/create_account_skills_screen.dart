import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/registration/create_account_skills/create_account_skills_controller.dart';
import 'package:para_job/features/registration/widgets/stepper.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart'
    show ApiCallState;
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/skill_item.dart';

import '../../../packages/themeing/app_colors.dart';

class CreateAccountSkillsScreen extends StatelessWidget {
  final controller = Get.put(CreateAccountSkillsController());

  CreateAccountSkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.hBox(2),
              StepperRow(currentStep: 4, stepPercentage: "80%"),
              context.hBox(2),
              Text(
                'Add skills',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
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
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.wPct(5),
          vertical: context.hPct(2.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: controller.validateAndContinue,
              child: Text("Continue"),
            ),

            context.hBox(5),
            GestureDetector(
              child: Text(
                "contact us",
                style: TextStyle(
                  color: AppColors.aquaTeal,
                  fontSize: context.wPct(4.2),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> skills = ["Plumbing", "Electrical Work", "Carpentry", "Painting"];
