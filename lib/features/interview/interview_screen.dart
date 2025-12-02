//Mary Mark ||  mary.mark@moselaymd.com || Tue Dec 02 2025 17:10:06

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/interview/interview_controller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';

class InterviewScreen extends StatelessWidget {
  InterviewScreen({super.key});
  final controller = Get.put(InterviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x14181BCC),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: Get.back,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.hBox(2),
              Text(
                'job_interview'.tr,
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(6),
                  fontWeight: FontWeight.w600,
                ),
              ),

              Obx(() {
                final contact = controller.contactInfo;
                switch (controller.interviewCallState.value) {
                  case ApiCallState.loading:
                    return SizedBox(
                      height: context.hPct(15),
                      child: Center(child: const CircularProgressIndicator()),
                    );

                  case ApiCallState.success:
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(context.defaultPadding),
                          width: context.width,
                          decoration: BoxDecoration(
                            color: AppColors.darkBackground,
                            borderRadius: BorderRadius.circular(
                              context.wPct(2.5),
                            ),
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
                                "title",
                                style: TextStyle(
                                  color: AppColors.pureWhite,
                                  fontSize: context.wPct(4.2),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              context.hBox(2),

                              ///interview name
                              Text(
                                "interviewer_name".tr,
                                style: TextStyle(
                                  color: AppColors.softWhite70,
                                  fontSize: context.wPct(3.5),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              context.hBox(1),
                              Text(
                                "title",
                                style: TextStyle(
                                  color: AppColors.pureWhite,
                                  fontSize: context.wPct(4.2),
                                  fontWeight: FontWeight.w600,
                                ),
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
                                "title",
                                style: TextStyle(
                                  color: AppColors.pureWhite,
                                  fontSize: context.wPct(4.2),
                                  fontWeight: FontWeight.w600,
                                ),
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
                                "title",
                                style: TextStyle(
                                  color: AppColors.pureWhite,
                                  fontSize: context.wPct(4.2),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              context.hBox(2),
                            ],
                          ),
                        ),

                        context.hBox(8),
                        InterviewButtons(),
                      ],
                    );

                  case ApiCallState.failure:
                    return Center(
                      child: ErrorScreen(
                        onPressed: () {
                          controller.fetchInterviewData();
                        },
                      ),
                    );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class InterviewButtons extends StatelessWidget {
  const InterviewButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton(
          onPressed: () {
            // controller.validateAndSubmit(context);
          },
          child: Text('accept_interview'.tr),
        ),

        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.rejected),
          ),
          child: Text('reject_interview'.tr),
        ),
      ],
    );
  }
}
