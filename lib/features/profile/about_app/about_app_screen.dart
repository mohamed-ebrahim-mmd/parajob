import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/about_app/about_app_conroller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';

class AboutAppScreen extends StatelessWidget {
  AboutAppScreen({super.key});

  final controller = Get.put(AboutAppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.charcoalBlack,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new), // Or your custom icon
          onPressed: () {
            Navigator.of(context).pop(); // Handle back action
          },
        ),
      ),
      body: Center(
        child: Obx(() {
          switch (controller.aboutUsCallState.value) {
            case ApiCallState.loading:
              return Center(child: const CircularProgressIndicator());

            case ApiCallState.success:
              final aboutUsData = controller.aboutUsData!;
              // Extract sections from the response
              final visionSection = aboutUsData.sections?[0];
              final missionSection = aboutUsData.sections?[1];
              final valuesSection = aboutUsData.sections?[2];

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.defaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.hBox(2),
                      //About ParaJob
                      Text(
                        'about_app_title'.tr,
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: context.wPct(6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      context.hBox(1),
                      Text(
                        aboutUsData.content ?? '',
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: context.wPct(4),
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      //Our Vision
                      context.hBox(3),
                      Text(
                        visionSection?.title ?? 'about_app_vision_default'.tr,

                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: context.wPct(6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      context.hBox(1),
                      Text(
                        visionSection?.content ?? '',
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: context.wPct(4),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      //Our Mission
                      context.hBox(3),

                      Text(
                        missionSection?.title ?? 'about_app_mission_default'.tr,
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: context.wPct(6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      context.hBox(1),
                      Text(
                        missionSection?.content ?? '',
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: context.wPct(4),
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      //Our values
                      context.hBox(2),
                      Text(
                        valuesSection?.title ?? 'about_app_values_default'.tr,

                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: context.wPct(6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      context.hBox(1),
                      Text(
                        valuesSection?.content ?? '',
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: context.wPct(4),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      context.hBox(2),
                    ],
                  ),
                ),
              );

            case ApiCallState.failure:
              return Center(
                child: ErrorScreen(
                  onPressed: () {
                    controller.fetchAboutUsDetails();
                  },
                ),
              );
          }
        }),
      ),
    );
  }
}
