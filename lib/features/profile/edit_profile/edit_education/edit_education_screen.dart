import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/edit_profile/edit_education/edit_education_controller.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/date_packer.dart';

class EditEducation extends StatelessWidget {
  EditEducation({super.key, required this.screenContext});
  final BuildContext screenContext;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditEducationController(screenContext));

    return Column(
      children: [
        context.hBox(2.5),
        // YearPickerField(
        //   selectedYear: int.tryParse(controller.user!.graduationYear ?? ""),
        //   controller: controller.graduationYearController,
        // ),

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
                decoration: const InputDecoration(
                  labelText: "Loading faculties...",
                  suffixIcon: Padding(
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
                hintText: "Choose your faculty",
                initialSelection: controller.selectedFacultyId,
                onSelected:controller.onFacultySelected,
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
          onPressed: controller.editUser,
          child: Text("Save changes"),
        ),
        context.hBox(2.5),
      ],
    );
  }
}
