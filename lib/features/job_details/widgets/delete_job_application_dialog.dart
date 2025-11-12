import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../job_details_controller.dart';

void deleteJobApplicationDialog({
  required BuildContext screenContext,
  required int applicationId,
  required JobDetailsController controller,
}) {
  final context = Get.context!;
  Get.dialog(
    Dialog(
      backgroundColor: AppColors.midnightBlue,
      insetPadding: EdgeInsets.symmetric(
        horizontal: context.wPct(4),
        vertical: 0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.wPct(4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: context.wPct(6),
              top: context.wPct(6),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.cancel_outlined,
                  color: Color(0xFF636B73),
                ),
              ),
            ),
          ),
          // Message
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  "Are you sure that you want to delete your application for this job?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.wPct(5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                context.hBox(4),
                OutlinedButton(
                  onPressed: () async {
                    await controller.withDrawJob(screenContext, applicationId);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: AppColors.coralRed),
                  ),
                  child: Text(
                    'Delete my application',
                    style: TextStyle(
                      color: AppColors.coralRed,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                context.hBox(1.5),
                Text(
                  "Warning: if you try to delete your application 48 hours before this you will pay a fee on your next job.",
                  style: TextStyle(
                    color: AppColors.white60,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          context.hBox(1),
        ],
      ),
    ),
    barrierDismissible: true,
  );
}
