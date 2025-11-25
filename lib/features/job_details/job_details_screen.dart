/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-16 10:52 AM
 ==================================================================
*/
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/job_details/job_details_controller.dart';
import 'package:para_job/features/job_details/widgets/delete_job_application_dialog.dart';
import 'package:para_job/features/job_details/widgets/job_content.dart'
    show JobContent;
import 'package:para_job/features/job_details/widgets/job_detail_container.dart';
import 'package:para_job/features/job_details/widgets/job_skill_item.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/api_client/src/extensions/job_data_extension.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/curved_image.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';
import 'package:para_job/res/app_asset_paths.dart';

class JobDetailsScreen extends StatelessWidget {
  final jobId = Get.arguments as int;
  late final controller = Get.put(
    JobDetailsController(jobId),
    tag: jobId.toString(),
  );

  JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.jobDetailsCallState.value) {
          case ApiCallState.loading:
            return const Center(child: CircularProgressIndicator());
          case ApiCallState.success:
            final jobDetails = controller.jobData!.data;
            log("🟢 ${jobDetails.isSubmitComplaint}");

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CurvedHeaderWithGlow(
                    imageUrl: jobDetails.logo,
                    child: JobContent(
                      jobDetails: jobDetails,
                      onCompanyTap: () {
                        Get.toNamed(
                          "${Routes.jobDetails}${Routes.employer}",
                          arguments: {'id': jobDetails.company.id},
                        );
                      },
                    ),
                  ),
                  context.hBox(4),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.defaultPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Company & Type Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: JobDetailContainer(
                                text: "${jobDetails.monthlySalary} ${'egp'.tr}",
                                iconPath: AppAssetPaths.money,
                              ),
                            ),
                            context.wBox(5),
                            Expanded(
                              child: JobDetailContainer(
                                text: jobDetails.displayType,
                                iconPath: AppAssetPaths.company,
                              ),
                            ),
                          ],
                        ),
                        context.hBox(3),
                        // Dates Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: JobDetailContainer(
                                text: controller.formatLocalizedDate(
                                  jobDetails.startDate,
                                ),
                                iconPath: AppAssetPaths.calender,
                              ),
                            ),
                            context.wBox(5),
                            Expanded(
                              child: JobDetailContainer(
                                text:
                                    "${controller.formatLocalizedTime(jobDetails.from)} - ${controller.formatLocalizedTime(jobDetails.to)}",
                                iconPath: AppAssetPaths.clocks,
                              ),
                            ),
                          ],
                        ),
                        context.hBox(3),

                        // Location
                        GestureDetector(
                          onTap: controller.openLocation,
                          child: JobDetailContainer(
                            text: jobDetails.location,
                            iconPath: AppAssetPaths.location,
                          ),
                        ),

                        // Description
                        context.hBox(3),
                        Text(
                          'description'.tr,
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontSize: context.wPct(5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        context.hBox(3),
                        Text(
                          jobDetails.description,
                          style: TextStyle(
                            color: AppColors.softWhite80,
                            fontSize: context.wPct(4),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // Requirements
                        context.hBox(3),
                        Text(
                          'requirements'.tr,
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontSize: context.wPct(5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        context.hBox(3),
                        Text(
                          jobDetails.requirements,
                          style: TextStyle(
                            color: AppColors.softWhite80,
                            fontSize: context.wPct(4),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // Required Skills
                        context.hBox(3),
                        Text(
                          'required_skills'.tr,
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontSize: context.wPct(5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        context.hBox(3),
                        Wrap(
                          spacing: context.wPct(3),
                          runSpacing: context.wPct(3),
                          children: jobDetails.skills
                              .map((skill) => JobSkillItem(skill: skill))
                              .toList(),
                        ),
                        context.hBox(4),
                        // Apply / Delete buttons
                        jobDetails.isApplied
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: TextButton(
                                      onPressed: () {
                                        deleteJobApplicationDialog(
                                          applicationId:
                                              jobDetails.applicationId!,
                                          controller: controller,
                                          screenContext: context,
                                        );
                                      },
                                      child: Text(
                                        'delete_my_application'.tr,
                                        style: TextStyle(
                                          color: AppColors.rejected,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : FilledButton(
                                onPressed: controller.handleApplyJobPressed,
                                child: Text('apply_for_job'.tr),
                              ),
                        context.hBox(4),
                      ],
                    ),
                  ),
                ],
              ),
            );
          case ApiCallState.failure:
            return Center(
              child: ErrorScreen(
                onPressed: () {
                  controller.fetchJobDetails(jobId);
                },
              ),
            );
        }
      }),
      bottomNavigationBar: Obx(() {
        final state = controller.jobDetailsCallState.value;

        if (state != ApiCallState.success) return const SizedBox.shrink();

        final jobDetails = controller.jobData!.data;
        if (!jobDetails.canLogAttendance) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 50),
          child: FilledButton(
            onPressed: () {
              Get.toNamed(
                Routes.checkInOut,
                arguments: {'jobId': jobId, 'hasAttendance': jobDetails.hasAttendance},
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppAssetPaths.barcode,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 8),
                Text('log_attendance'.tr),
              ],
            ),
          ),
        );
      }),
    );
  }
}
