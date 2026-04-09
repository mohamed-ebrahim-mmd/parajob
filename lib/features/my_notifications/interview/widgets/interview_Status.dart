//Mary Mark ||  mary.mark@moselaymd.com || Wed Dec 03 2025 11:58:47

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:para_job/features/my_notifications/interview/interview_controller.dart';
import 'package:para_job/packages/api_client/src/enums/interview_status_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class InterviewStatus extends StatelessWidget {
  InterviewStatus({super.key, required this.status});

  final controller = Get.find<InterviewController>();

  final InterviewStatusEnum
  status; // accepted / rejected / not_determined/pending

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case InterviewStatusEnum.accepted:
        return Column(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.aquaTeal,
              size: context.wPct(12),
            ),
            context.hBox(2),
            Text(
              'interview_accepted'.tr,
              style: TextStyle(
                color: AppColors.aquaTeal,
                fontSize: context.wPct(4),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );

      case InterviewStatusEnum.rejected:
        return Column(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: AppColors.rejected,
              size: context.wPct(12),
            ),
            context.hBox(2),
            Text(
              'interview_rejected'.tr,
              style: TextStyle(
                color: AppColors.rejected,
                fontSize: context.wPct(4),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );

      case InterviewStatusEnum.pending:
        return Column(
          children: [
            FilledButton(
              onPressed: () => controller.sendAcceptedStatus(context),
              child: Text('accept_interview'.tr),
            ),
            context.hBox(2),
            OutlinedButton(
              onPressed: () => controller.sendRejectedStatus(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.rejected),
              ),
              child: Text(
                'reject_interview'.tr,
                style: TextStyle(color: AppColors.rejected),
              ),
            ),
          ],
        );

      default:
        return Text("snackbar_something_went_wrong".tr);
    }
  }
}
