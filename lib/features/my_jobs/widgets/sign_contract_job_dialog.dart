/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-30 2:20 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/features/my_jobs/application_verification_otp/application_verification_otp_controller.dart';
import 'package:para_job/packages/api_client/src/models/responses/my_job.dart'
    show MyJob;
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

void signContractJobDialog(
  MyJob job,
  PagingController<int, MyJob> approvedJobController,
) {
  final context = Get.context!;
  Get.dialog(
    Dialog(
      backgroundColor: AppColors.midnightBlue, // dark background
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
          // Close icon aligned top-right
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
            padding: EdgeInsets.all(context.wPct(8)),
            child: Column(
              children: [
                Text(
                  'my_job_dialog_congrats'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.wPct(5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                context.hBox(4),
                // Button
                FilledButton(
                  onPressed: () {
                    _navigateToApplicationVerificationOTP(
                      job.id,
                      approvedJobController,
                    );
                  },
                  child: Text(
                    'my_job_dialog_sign_contract'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
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

void _navigateToApplicationVerificationOTP(
  int jobId,
  PagingController<int, MyJob> approvedJobController,
) {
  Get.back(); // close dialog first
  Get.put(
    ApplicationVerificationOtpController(
      jobId: jobId,
      approvedJobController: approvedJobController,
    ),
  );
  Get.toNamed("${Routes.mainNavigator}${Routes.applicationVerificationOTP}");
}
