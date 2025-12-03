//Mary Mark ||  mary.mark@moselaymd.com || Tue Dec 02 2025 17:10:06

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/my_notifications/interview/interview_controller.dart';
import 'package:para_job/features/my_notifications/interview/widgets/interview_Status.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/api_client/src/enums/interview_status_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/app_network_image.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';

class InterviewScreen extends StatelessWidget {
  const InterviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final id = args['id'];
    final controller = Get.put(InterviewController(id: id));
    return Scaffold(
      backgroundColor: AppColors.backg,
      appBar: AppBar(
        backgroundColor: AppColors.backg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: Get.back,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: Obx(() {
          var interviewData = controller.interviewData;
          switch (controller.interviewCallState.value) {
            case ApiCallState.loading:
              return Center(
                child: SizedBox(
                  height: context.hPct(15),
                  child: Center(child: const CircularProgressIndicator()),
                ),
              );

            case ApiCallState.success:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    context.hBox(2),

                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'job_interview'.tr,
                              style: TextStyle(
                                color: AppColors.pureWhite,
                                fontSize: context.wPct(6),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            context.hBox(2),
                            Text(
                              interviewData!.company?.name ?? "_",
                              style: TextStyle(
                                color: AppColors.lightSilverGray,
                                fontSize: context.wPct(3.5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        AppNetworkImage(
                          url: interviewData.company?.logo ?? "_",
                          width: context.wPct(12),
                          height: context.wPct(12),
                          borderRadius: BorderRadius.circular(context.wPct(2)),
                        ),
                      ],
                    ),

                    context.hBox(3),

                    Container(
                      padding: EdgeInsets.all(context.defaultPadding),
                      width: context.width,
                      decoration: BoxDecoration(
                        color: AppColors.darkBackground,
                        borderRadius: BorderRadius.circular(context.wPct(2.5)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///job title
                          Text(
                            "job_title".tr,
                            style: TextStyle(
                              color: AppColors.softWhite70,
                              fontSize: context.wPct(3.5),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          context.hBox(1),
                          Text(
                            interviewData.job?.title ?? "_",
                            style: TextStyle(
                              color: AppColors.pureWhite,
                              fontSize: context.wPct(4.2),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          context.hBox(2),

                          ///interview name
                          Text(
                            "date".tr,
                            style: TextStyle(
                              color: AppColors.softWhite70,
                              fontSize: context.wPct(3.5),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          context.hBox(1),
                          Text(
                            interviewData.interviewDate ?? "_",
                            style: TextStyle(
                              color: AppColors.pureWhite,
                              fontSize: context.wPct(4.2),
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          context.hBox(2),

                          ///mode
                          Text(
                            "interview_mode".tr,
                            style: TextStyle(
                              color: AppColors.softWhite70,
                              fontSize: context.wPct(3.5),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          context.hBox(1),
                          Text(
                            interviewData.mode ?? "_",
                            style: TextStyle(
                              color: AppColors.pureWhite,
                              fontSize: context.wPct(4.2),
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          context.hBox(2),
                          //link
                          Text(
                            "meeting_link".tr,
                            style: TextStyle(
                              color: AppColors.softWhite70,
                              fontSize: context.wPct(3.5),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          context.hBox(1),
                          Text(
                            interviewData.meetingLink ?? "_",
                            style: TextStyle(
                              color: AppColors.pureWhite,
                              fontSize: context.wPct(4.2),
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          context.hBox(2),
                        ],
                      ),
                    ),

                    context.hBox(4),
                    InterviewStatus(
                      status:
                          interviewData.userResponse ??
                          InterviewStatusEnum.pending,
                    ),
                    context.hBox(4),
                  ],
                ),
              );

            case ApiCallState.failure:
              return Center(
                child: ErrorScreen(
                  onPressed: () {
                    controller.fetchInterviewData(id);
                  },
                ),
              );
          }
        }),
      ),
    );
  }
}
