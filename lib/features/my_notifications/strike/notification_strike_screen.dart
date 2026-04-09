// Karim Toson || kareemtoson1@gmail.com || 19/11/2025 2:06 PM

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/my_notifications/strike/notification_strike_controller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';
import 'package:para_job/packages/ui_components/strikes_details.dart';

class NotificationStrikeScreen extends StatelessWidget {
  NotificationStrikeScreen({super.key});

  final NotificationStrikeController controller = Get.put(
    NotificationStrikeController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop(); // Handle back action
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
          child: Center(
            child: SingleChildScrollView(
              child: Obx(() {
                switch (controller.strikesCallState.value) {
                  case ApiCallState.loading:
                    return Center(child: CircularProgressIndicator());

                  case ApiCallState.success:
                    return Column(
                      children: [
                        Text(
                          "warning_label".tr,

                          style: TextStyle(
                            color: AppColors.rejected,
                            fontSize: context.wPct(7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        context.hBox(.5),
                        Text(
                          "violation_rules".tr,
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontSize: context.wPct(4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        context.hBox(.5),
                        StrikesDetails(strikes: controller.strikesData),

                        context.hBox(4),

                        //Why you don’t want to get a warning?
                        Align(
                          alignment:
                              Directionality.of(context) == TextDirection.rtl
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(
                            "warning_info_title".tr,
                            style: TextStyle(
                              color: AppColors.pureWhite,
                              fontSize: context.wPct(4.3),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        context.hBox(1),
                        Align(
                          alignment:
                              Directionality.of(context) == TextDirection.rtl
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(
                            "warning_consequences_list".tr,
                            style: TextStyle(
                              color: AppColors.softWhite80,
                              fontSize: context.wPct(4),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),

                        Align(
                          alignment:
                              Directionality.of(context) == TextDirection.rtl
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(
                            "warning_info_tips".tr,
                            style: TextStyle(
                              color: AppColors.pureWhite,
                              fontSize: context.wPct(4.3),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        context.hBox(1),
                        Align(
                          alignment:
                              Directionality.of(context) == TextDirection.rtl
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(
                            "warning_tips_list".tr,
                            style: TextStyle(
                              color: AppColors.softWhite80,
                              fontSize: context.wPct(4),
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        context.hBox(2),
                      ],
                    );

                  case ApiCallState.failure:
                    return Center(
                      child: ErrorScreen(
                        onPressed: () {
                          controller.fetchStrikesDetails();
                        },
                      ),
                    );
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
