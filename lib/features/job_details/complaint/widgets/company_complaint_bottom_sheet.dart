import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/auth_required_dialog.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import 'complaint_item.dart';

void showCompanyComplaintBottomSheet({
  required String companyName,
  required int companyId,
  required bool companyIsSubmitComplaint,
  String? jobTitle,
  int? jobId,
  bool? jobIsSubmitComplaint,
}) {
  final user = Get.find<UserController>();
  final context = Get.context!;

  Get.bottomSheet(
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.dialogBackgroundDark,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.wPct(6)),
        ),
      ),
      padding: EdgeInsets.all(context.wPct(6)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          companyIsSubmitComplaint
              ? Text(
                  'company_already_complaint'.tr,
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(4),
                    fontWeight: FontWeight.w400,
                  ),
                )
              : ComplaintItem(
                  title: '${'complaint_about'.tr} $companyName',
                  onTap: () {
                    if (user.isGuest) {
                      showAuthRequiredDialog();
                    } else {
                      Get.back();
                      Get.toNamed(
                        "${Routes.jobDetails}${Routes.employer}${Routes.companyComplaint}",
                        arguments: {'id': companyId, 'title': companyName},
                      );
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
