import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/home_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CommonShowcaseTooltip extends StatelessWidget {
  final String description;
  final bool isLast;
  final bool showBack;
  final int currentStep;
  final int totalSteps;

  CommonShowcaseTooltip({
    super.key,
    required this.description,
    this.isLast = false,
    this.showBack = true,
    this.currentStep = 0,
    this.totalSteps = 3,
  });

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.wPct(4)),
      decoration: BoxDecoration(
        color: AppColors.dialogBackgroundDark,
        borderRadius: BorderRadius.circular(context.wPct(3)),
      ),
      constraints: BoxConstraints(maxWidth: context.wPct(80)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => controller.goDismiss(),
                child: Align(
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
              ),
            ],
          ),
          context.hBox(1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wPct(2)),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.pureWhite,
                fontSize: context.wPct(3.8),
              ),
            ),
          ),
          context.hBox(2),

          /// --- PAGE INDICATOR DOTS ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalSteps, (index) {
              final isActive = index == currentStep;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? AppColors.aquaTeal : AppColors.darkNavy,
                ),
              );
            }),
          ),

          context.hBox(1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showBack)
                TextButton(
                  onPressed: () => controller.goBack(),
                  child: Text(
                    "back".tr,
                    style: const TextStyle(color: AppColors.gray8D),
                  ),
                )
              else
                const SizedBox.shrink(),
              TextButton(
                onPressed: () => controller.goNext(),
                child: Text(
                  isLast ? "done".tr : "next".tr,
                  style: TextStyle(
                    color: isLast ? AppColors.aquaTeal : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
