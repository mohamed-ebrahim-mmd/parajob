import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/about_us/about_us_content_conroller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';

class AboutUsContentScreen extends StatelessWidget {
  AboutUsContentScreen({super.key});

  final controller = Get.put(AboutUsContentConroller());

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
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: context.wPct(5),
                    vertical: context.hPct(2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //About ParaJob
                      Text(
                        "About ParaJob",
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
                        "Our Vision",
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
                        "Our Mission",
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
                        "Our values",
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
