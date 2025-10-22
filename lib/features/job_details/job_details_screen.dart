import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/job_details/job_details_controller.dart';
import 'package:para_job/features/job_details/widgets/custom_container_job_detail.dart';
import 'package:para_job/features/job_details/widgets/job_content.dart'
    show JobContent;
import 'package:para_job/features/job_details/widgets/job_skill_item.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/curved_image.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';
import 'package:para_job/res/app_asset_paths.dart';

class JobDetailsScreen extends StatelessWidget {
  final jobId = Get.arguments as int;
  late final controller = Get.put(JobDetailsController(jobId));

  JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.jobDetailsCallState.value) {
          case ApiCallState.loading:
            return Center(child: CircularProgressIndicator());
          case ApiCallState.success:
            final jobDetails = controller.jobData!.data;

            return SingleChildScrollView(
              child: Column(
                //  crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  CurvedHeaderWithGlow(
                    imageUrl: jobDetails.logo,
                    child: JobContent(
                      jobDetails: jobDetails,
                      onCompanyTap: () {
                        Get.toNamed(
                          "${Routes.jobDetails}${Routes.companyDetails}",
                          arguments: jobDetails.company.id,
                        );
                      },
                    ),
                  ),
                  context.hBox(4),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: context.wPct(5),
                    ),
                    //company
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomContainerJobDetail(
                                text: jobDetails.monthlySalary,
                                iconPath: AppAssetPaths.money,
                              ),
                            ),
                            context.wBox(5),
                            Expanded(
                              child: CustomContainerJobDetail(
                                text: jobDetails.type,
                                iconPath: AppAssetPaths.company,
                              ),
                            ),
                          ],
                        ),
                        context.hBox(3),
                        // time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomContainerJobDetail(
                                text: jobDetails.startDate,
                                iconPath: AppAssetPaths.calender,
                              ),
                            ),
                            context.wBox(5),
                            Expanded(
                              child: CustomContainerJobDetail(
                                text:
                                    "${jobDetails.from ?? "-"} - ${jobDetails.to ?? "-"}",
                                iconPath: AppAssetPaths.clocks,
                              ),
                            ),
                          ],
                        ),
                        context.hBox(3),
                        //location
                        CustomContainerJobDetail(
                          text: jobDetails.location,
                          iconPath: AppAssetPaths.location,
                        ),
                        //description
                        context.hBox(3),
                        Text(
                          'Description',
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

                        //requirements
                        context.hBox(3),
                        Text(
                          'Requirements',
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
                        // required skills
                        context.hBox(3),
                        Text(
                          'Required Skills',
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
                        FilledButton(
                          onPressed: () {},
                          child: Text("Apply for this job"),
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
    );
  }
}
