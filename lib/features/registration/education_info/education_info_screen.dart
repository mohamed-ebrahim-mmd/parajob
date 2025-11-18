import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/registration/education_info/education_info_controller.dart';
import 'package:para_job/features/registration/widgets/stepper.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EducationInfoScreen extends StatelessWidget {
  final controller = Get.put(EducationInfoController());

  EducationInfoScreen({super.key});

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
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepperRow(currentStep: 3, stepPercentage: "60%"),
              context.hBox(4),
              Text(
                'education_info_title'.tr,
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(2.5),
              Obx(() {
                switch (controller.universitiesCallState.value) {
                  case ApiCallState.loading:
                    return TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'education_info_loading_universities'.tr,
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
                      hintText: 'education_info_university_hint'.tr,
                      initialSelection: controller.selectedUniversityId.value,
                      onSelected: controller.onUniversitySelected,
                      dropdownMenuEntries: controller.universityMenuEntries,
                    );

                  case ApiCallState.failure:
                    return GestureDetector(
                      onTap: controller.fetchUniversities,
                      child: AbsorbPointer(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText:
                                'education_info_failed_load_universities'.tr,
                            suffixIcon: Icon(Icons.refresh),
                          ),
                        ),
                      ),
                    );
                }
              }),
              context.hBox(1.5),
              Obx(() {
                switch (controller.facultiesCallState.value) {
                  case DataFetchState.loading:
                    return TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'education_info_loading_faculties'.tr,
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );

                  case DataFetchState.success:
                    return DropdownMenu<int>(
                      enableSearch: true,
                      expandedInsets: EdgeInsets.zero,
                      menuHeight: context.hPct(30),
                      hintText: 'education_info_faculty_hint'.tr,
                      initialSelection: controller.selectedFacultyId,
                      onSelected: (value) {
                        if (value != null) {
                          controller.selectedFacultyId = value;
                        }
                      },
                      dropdownMenuEntries: controller.facultyMenuEntries,
                    );

                  case DataFetchState.failure:
                    return GestureDetector(
                      onTap: () {
                        if (controller.selectedUniversityId.value != null) {
                          controller.fetchFaculties(
                            controller.selectedUniversityId.value!,
                          );
                        }
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText:
                                'education_info_failed_load_faculties'.tr,
                            suffixIcon: Icon(Icons.refresh),
                          ),
                        ),
                      ),
                    );

                  case DataFetchState.initial:
                    return TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'education_info_select_university_first'.tr,
                      ),
                    );
                }
              }),

              context.hBox(1.5),
              TextField(
                readOnly: true,
                controller: controller.graduationYearController,
                decoration: InputDecoration(
                  hintText: controller.graduationYearController.text.isEmpty
                      ? 'education_info_graduation_year_hint'.tr
                      : controller.graduationYearController.text,
                ),
                onTap: controller.pickGraduationYear,
              ),

              //status dropDown
              context.hBox(1.5),
              DropdownMenu<String>(
                enableSearch: true,
                expandedInsets: EdgeInsets.zero,
                hintText: 'education_info_status_hint'.tr,
                initialSelection: controller.selectedStatus,
                onSelected: controller.onStatusSelected,
                dropdownMenuEntries: controller.statusMenuEntries,
              ),
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
              onPressed: controller.onSubmitEducationInfo,
              child: Text('education_info_continue_button'.tr),
            ),

            context.hBox(5),
            GestureDetector(
              child: Text(
                'education_info_contact_us'.tr,
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
