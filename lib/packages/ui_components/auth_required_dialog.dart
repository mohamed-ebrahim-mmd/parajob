/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-15 10:49 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

void showAuthRequiredDialog() {
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
                  'auth_required_title'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.wPct(5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                context.hBox(4),
                // Button
                FilledButton(
                  onPressed: () async {
                    await Get.find<RoutingController>().logOut();
                  },
                  child: Text(
                    'auth_required_button'.tr,
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
