import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

void complaintSuccessDialog() {
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
            padding: EdgeInsets.all(context.wPct(8)),
            child: Column(
              children: [
                Text(
                  "Your complaint has been submitted, wait for our team to connect with you.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.wPct(5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                context.hBox(4),
                FilledButton(
                  onPressed: () {
                    Get.back();
                    Get.offAllNamed(Routes.mainNavigator);
                  },
                  child: const Text(
                    "Go back to Home",
                    style: TextStyle(
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
  ).then((_) {
    Get.offAllNamed(Routes.mainNavigator);
  });
}
