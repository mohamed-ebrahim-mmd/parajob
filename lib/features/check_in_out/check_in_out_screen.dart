import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:para_job/features/check_in_out/check_in_out_controller.dart';
import 'package:para_job/features/check_in_out/widgets/check_in_out_status.dart';
import 'package:para_job/features/check_in_out/widgets/check_in_out_timeline_item.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../../../packages/api_client/src/enums/api_call_state_enum.dart';
import '../../../packages/ui_components/error_screen.dart';
import '../barcode/widgets/scanner_button.dart';

class CheckInOutScreen extends StatelessWidget {
  final args = Get.arguments as Map<String, dynamic>;
  late final int jobId = args['jobId'] as int;

  late final controller = Get.put(CheckInOutController(jobId: jobId));

  CheckInOutScreen({super.key});

  final DateFormat timeFormat = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        switch (controller.callState.value) {
          case ApiCallState.loading:
            return const Center(child: CircularProgressIndicator());

          case ApiCallState.success:
            final data = controller.activeCheckInOutHistory.value;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.hBox(2),
                  Text(
                    'attendance_log'.tr,
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: context.wPct(7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 7),

                  Text(
                    controller.hasAttendance.value == false &&
                            controller.checkOutStatus.value == false
                        ? 'scan_qr_to_check_in'.tr
                        : "full_shift_requires_hours".trParams({
                            'hours': controller.shiftHours.value.toString(),
                          }),
                    style: TextStyle(
                      color: AppColors.softWhite70,
                      fontSize: context.wPct(3.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 340,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 340,
                          decoration: BoxDecoration(
                            color: AppColors.darkCharcoal,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: CheckInOutStatus(),
                        ),
                        Positioned(
                          top: -27,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    controller.user.user!.profilePicture
                                        .toString(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      CheckInOutTimelineItem(
                        title: "checked_in_at".tr,
                        value: data?.checkInAt != null
                            ? timeFormat.format(data!.checkInAt!)
                            : "--",
                        isActive: data?.checkInAt != null,
                      ),
                      const SizedBox(height: 5),
                      CheckInOutTimelineItem(
                        title: "checked_out_at".tr,
                        value: data?.checkOutAt != null
                            ? timeFormat.format(data!.checkOutAt!)
                            : "--",
                        isActive: data?.checkOutAt != null,
                      ),
                      const SizedBox(height: 5),
                      CheckInOutTimelineItem(
                        title: "extra_time".tr,
                        value: (data?.extraTime ?? 0) > 0
                            ? "${data!.extraTime!} h"
                            : "--",
                        isActive: (data?.extraTime ?? 0) > 0,
                        isLast: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (controller.checkOutStatus.value == false)
                    Center(
                      child: ScannerButton(
                        title: controller.hasAttendance.value == false
                            ? 'check_in'.tr
                            : 'check_out'.tr,
                        onScanned: (code) {
                          controller.scan(context, code.split('/').last);
                        },
                      ),
                    ),
                  const SizedBox(height: 12),
                ],
              ),
            );

          case ApiCallState.failure:
            return Center(
              child: ErrorScreen(
                onPressed: () {
                  controller.getActiveCheckInOut();
                },
              ),
            );
        }
      }),
    );
  }
}
