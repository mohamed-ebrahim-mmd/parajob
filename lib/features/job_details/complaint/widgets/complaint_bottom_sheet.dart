import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/auth_required_dialog.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

void showComplaintBottomSheet({
  required String companyName,
  required int companyId,
  required bool companyIsSubmitComplaint,
  String? jobTitle,
  int? jobId,
  bool? jobIsSubmitComplaint,
  
}) {
  final user = Get.find<UserController>();
  final context =Get.context!;

  Get.bottomSheet(
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.midnightBlue,
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
                  'You have already filed a complaint for this company.',
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(4),
                    fontWeight: FontWeight.w400,
                  ),
                )
              : ComplaintItem(
                  title: 'Complaint about $companyName',
                  onTap: () {
                    if (user.isGuest) {
                      showAuthRequiredDialog();
                    } else {
                      Get.back();
                      Get.toNamed(
                        "${Routes.jobDetails}${Routes.employer}${Routes.complaint}",
                        arguments: {
                          'id': companyId,
                          'isCompany': true,
                          'title': companyName,
                        },
                      );
                    }
                  },
                ),
                context.hBox(2)
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

class ComplaintItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ComplaintItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.wPct(3)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: context.hPct(2),
          horizontal: context.wPct(4.5),
        ),
        decoration: BoxDecoration(
          color: AppColors.white5,
          borderRadius: BorderRadius.circular(context.wPct(3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(4),
                  fontWeight: FontWeight.w400,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.pureWhite,
              size: context.wPct(5),
            ),
          ],
        ),
      ),
    );
  }
}
