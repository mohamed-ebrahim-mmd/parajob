//Mary Mark ||  mary.mark@moselaymd.com || Wed Nov 19 2025 14:30:17

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/home_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class StartTutorialDialog extends StatelessWidget {
  StartTutorialDialog({super.key});

  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.wPct(6)),
      decoration: BoxDecoration(
        color: AppColors.dialogBackgroundDark,
        borderRadius: BorderRadius.circular(context.wPct(3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Close icon aligned top-right
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: GestureDetector(
              onTap: () => controller.goDismiss(),
              child: Container(
                padding: const EdgeInsets.all(2.0),
                decoration: const BoxDecoration(
                  color: AppColors.darkSlate,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: AppColors.mediumSlateGrey,
                  size: 18.0,
                ),
              ),
            ),
          ),

          /// --- SVG IMAGE ---
          SvgPicture.asset(AppAssetPaths.tutorial),

          context.hBox(1.5),

          /// --- TITLE ---
          Text(
            "start_parajob".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.wPct(5),
              fontWeight: FontWeight.w600,
              color: AppColors.pureWhite,
            ),
          ),

          context.hBox(1.5),

          /// --- DESCRIPTION ---
          Text(
            "start_parajob_desc".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.wPct(3.5),
              color: AppColors.mediumGray,
            ),
          ),

          context.hBox(2),

          /// --- BUTTON ---
          FilledButton(
            onPressed: () => controller.goNext(),
            child: Text(
              "start_now".tr,
              style: TextStyle(
                fontSize: context.wPct(5),
                fontWeight: FontWeight.w400,
                color: AppColors.pureWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
