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
                SizedBox(width: context.wPct(3)), // Spacing 3% of screen width
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
    mainText: "Something Went Wrong",
    subText: 'Please check your connection and try again.',
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
