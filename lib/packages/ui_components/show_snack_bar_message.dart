/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-30 4:21 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

void showSnackBarMessage({
  required String mainText,
  required String subText,
  required IconData icon,
  required Color color,
}) {
  if (Get.isSnackbarOpen) return;
  Get.rawSnackbar(
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.transparent,
    // Transparent for custom design
    duration: const Duration(seconds: 2),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    messageText: Builder(
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(context.wPct(4)), // 4% of screen width
            child: Row(
              children: [
                Icon(
                  icon,
                  size: context.wPct(7), // Icon size 7% of screen width
                  color: Colors.white,
                ),
                context.wBox(3),
                // Spacing 3% of screen width
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mainText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.wPct(
                            4.5,
                          ), // Font size 4.5% of screen width
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: context.hPct(0.5),
                      ), // 0.5% of screen height
                      Text(
                        subText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.wPct(
                            3.5,
                          ), // Font size 3.5% of screen width
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

void showSnackBarJobApplicationCongrats() {
  final context = Get.context!;
  if (Get.isSnackbarOpen) return;
  Get.rawSnackbar(
    snackStyle: SnackStyle.FLOATING,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.transparent,
    margin: EdgeInsets.only(
      top: context.hPct(45), // vertically center (adjust as needed)
      left: context.wPct(5),
      right: context.wPct(5),
    ),
    duration: const Duration(seconds: 2),
    messageText: Container(
      alignment: Alignment.center,
      height: Get.context!.hPct(15),
      padding: EdgeInsets.all(context.wPct(4)),
      decoration: BoxDecoration(
        color: AppColors.dialogBackgroundDark, // dark background
        borderRadius: BorderRadius.circular(context.wPct(4)),
      ),
      child: Text(
        'snackbar_job_application_congrats'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.pureWhite,
          fontSize: context.wPct(4),
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

void showJobContractSuccessSnackBar() {
  final context = Get.context!;
  if (Get.isSnackbarOpen) return;
  Get.rawSnackbar(
    snackStyle: SnackStyle.FLOATING,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.transparent,
    margin: EdgeInsets.only(
      top: context.hPct(45), // vertically center (adjust as needed)
      left: context.wPct(5),
      right: context.wPct(5),
    ),
    duration: const Duration(seconds: 2),
    messageText: Container(
      alignment: Alignment.center,
      height: Get.context!.hPct(15),
      padding: EdgeInsets.all(context.wPct(4)),
      decoration: BoxDecoration(
        color: AppColors.dialogBackgroundDark, // dark background
        borderRadius: BorderRadius.circular(context.wPct(4)),
      ),
      child: Text(
        'snackbar_job_contract_signed'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.pureWhite,
          fontSize: context.wPct(4),
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

void showSnackBarError(String title, String message) {
  showSnackBarMessage(
    mainText: title,
    subText: message,
    icon: Icons.error_outline_rounded,
    color: AppColors.coralRed,
  );
}

void showSnackBarApiError() {
  showSnackBarMessage(
    mainText: 'snackbar_something_went_wrong'.tr,
    subText: 'snackbar_check_connection'.tr,
    icon: Icons.error_outline_rounded,
    color: AppColors.coralRed,
  );
}

void showSnackBarSuccess(String title, String message) {
  showSnackBarMessage(
    mainText: title,
    subText: message,
    icon: Icons.check_circle_outline_rounded,
    color: AppColors.aquaTeal,
  );
}

void showSnackBarComplaintSuccess() {
  final context = Get.context!;
  if (Get.isSnackbarOpen) return;
  Get.rawSnackbar(
    snackStyle: SnackStyle.FLOATING,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.transparent,
    margin: EdgeInsets.only(
      top: context.hPct(45), // vertically center (adjust as needed)
      left: context.wPct(5),
      right: context.wPct(5),
    ),
    duration: const Duration(seconds: 2),
    messageText: Container(
      alignment: Alignment.center,
      height: Get.context!.hPct(20),
      padding: EdgeInsets.all(context.wPct(4)),
      decoration: BoxDecoration(
        color: AppColors.dialogBackgroundDark, // dark background
        borderRadius: BorderRadius.circular(context.wPct(4)),
      ),
      child: Text(
        'snackbar_complaint_success'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.pureWhite,
          fontSize: context.wPct(4.5),
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
