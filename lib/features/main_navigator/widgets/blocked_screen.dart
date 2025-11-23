//Mary Mark ||  mary.mark@moselaymd.com || Sun Nov 23 2025 12:25:19

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/main_navigator/main_navigator_controller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';
import 'package:para_job/packages/ui_components/strikes_details.dart';

class BlockedScreen extends StatelessWidget {
  BlockedScreen({super.key});

  final controller = Get.find<MainNavigatorController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: Center(
          child: SingleChildScrollView(
            child: Obx(() {
              switch (controller.isBlockedCallState.value) {
                case ApiCallState.loading:
                  return Center(child: CircularProgressIndicator());

                case ApiCallState.success:
                  return Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "account_disabled".tr,
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: context.wPct(8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      context.hBox(1),
                      controller.strikesData.isNotEmpty
                          ? StrikesDetails(strikes: controller.strikesData)
                          : SizedBox.shrink(),

                      context.hBox(4),
                    ],
                  );

                case ApiCallState.failure:
                  return Center(
                    child: ErrorScreen(
                      onPressed: () {
                        controller.fetchBlockStatus();
                      },
                    ),
                  );
              }
            }),
          ),
        ),
      ),
    );
  }
}
