import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/app_star_rating_interactive.dart';

import '../employer_controller.dart';

class EmployerSubmitReview extends StatelessWidget {
  final controller = Get.find<EmployerController>();

  EmployerSubmitReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "write_review".tr, // localized
          style: TextStyle(
            fontSize: context.wPct(5),
            fontWeight: FontWeight.w600,
          ),
        ),
        context.hBox(1.5),

        Obx(
          () => AppStarRatingInteractive(
            initialRating: controller.selectedRating.value,
            onChanged: (rating) => controller.selectedRating.value = rating,
            size: context.wPct(1.6),
          ),
        ),

        context.hBox(2),

        TextField(
          controller: controller.reviewController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: "share_opinion".tr, // localized hint
          ),
        ),
        context.hBox(1),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Theme(
              data: Theme.of(Get.context!).copyWith(
                checkboxTheme: CheckboxThemeData(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: BorderSide(
                    color: AppColors.pureWhite,
                    width: context.wPct(0.2),
                  ),
                ),
              ),
              child: Obx(() {
                return Checkbox(
                  value: controller.isAnonymous.value,
                  onChanged: (value) {
                    controller.isAnonymous.value = value ?? false;
                  },
                  activeColor: AppColors.aquaTeal,
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }),
            ),
            context.wBox(1),
            Expanded(
              child: Text(
                'anonymous_member'.tr, // localized
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontWeight: FontWeight.w400,
                  fontSize: context.wPct(3.5),
                ),
              ),
            ),
          ],
        ),

        context.hBox(2),
        FilledButton(
          onPressed: () {
            controller.submitReview();
          },
          child: Text("submit".tr), // localized
        ),
      ],
    );
  }
}
