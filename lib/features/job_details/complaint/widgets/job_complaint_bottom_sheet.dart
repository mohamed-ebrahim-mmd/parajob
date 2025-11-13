import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/job_details/complaint/widgets/complaint_item.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/auth_required_dialog.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

void showJobComplaintBottomSheet({
  required String jobName,
  required int jobId,
  required bool isSubmitComplaint,
}) {
  final user = Get.find<UserController>();
  final context = Get.context!;

  Get.bottomSheet(
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.midnightBlue,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.wPct(6)),
        ),
      ),
      padding: EdgeInsets.all(context.wPct(6)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isSubmitComplaint
              ? Text(
                  'you are submitted a complain about this job',
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(4),
                    fontWeight: FontWeight.w400,
                  ),
                )
              : ComplaintItem(
                  title: 'complaint about the $jobName job',
                  onTap: () {
                    if (user.isGuest) {
                      showAuthRequiredDialog();
                    } else {
                      Get.back();
                      //todo implement the logic for the job compliment here
                    }
                  },
                ),
          context.hBox(2),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}
