//Mary Mark ||  mary.mark@moselaymd.com || Wed Dec 03 2025 11:58:47

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class InterviewStatus extends StatelessWidget {
  const InterviewStatus({super.key, required this.status});

  final String status; // accepted / rejected / not_determined

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 'accepted':
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

      case 'rejected':
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

      default:
        return Column(
          children: [
            FilledButton(onPressed: () {}, child: Text('accept_interview'.tr)),
            context.hBox(3),
            OutlinedButton(
              onPressed: () {},
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
    }
  }
}
