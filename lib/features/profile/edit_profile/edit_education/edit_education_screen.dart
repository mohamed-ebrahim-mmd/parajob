import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/edit_profile/edit_education/edit_education_controller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EditEducation extends StatelessWidget {
  final BuildContext screenContext;

  EditEducation({super.key, required this.screenContext});

  late final controller = Get.put(EditEducationController(screenContext));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.hBox(2.5),
        TextField(
          readOnly: true,
          controller: controller.graduationYearController,
          onTap: controller.pickGraduationYear,
        ),

        context.hBox(2.5),

        Obx(() {
          switch (controller.facultiesCallState.value) {
            case ApiCallState.loading:
              return TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'edit_education_loading_faculties'.tr,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              );

            case ApiCallState.success:
              return DropdownMenu<int>(
                enableSearch: true,
                expandedInsets: EdgeInsets.zero,
                menuHeight: context.hPct(30),
                hintText: 'edit_education_faculty_hint'.tr,
                initialSelection: controller.selectedFacultyId,
                onSelected: controller.onFacultySelected,
                dropdownMenuEntries: controller.facultyMenuEntries,
              );

            case ApiCallState.failure:
              return GestureDetector(
                onTap: () {
                  controller.fetchFaculties(controller.user!.university!);
                },
                child: AbsorbPointer(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'edit_education_failed_load'.tr,
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
          child: Text('edit_education_save_button'.tr),
        ),
        context.hBox(2.5),
      ],
    );
  }
}
