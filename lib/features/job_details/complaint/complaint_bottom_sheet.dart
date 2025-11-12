import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
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

  Get.bottomSheet(
    Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.midnightBlue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ?(jobId != null && jobTitle != null)
              ? jobIsSubmitComplaint == true
                    ? Text(
                        'You have already filed a complaint for this job.',
                        style: const TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : _buildComplaintItem(
                        title: 'Complaint about the job',
                        onTap: () {
                          if (user.isGuest) {
                            showAuthRequiredDialog();
                          } else {
                            Get.back();
                            Get.toNamed(
                              Routes.complaint,
                              arguments: {
                                'id': jobId,
                                'isCompany': false,
                                'title': jobTitle,
                              },
                            );
                          }
                        },
                      )
              : null,
          const SizedBox(height: 20),
          companyIsSubmitComplaint == true
              ? Text(
                  'You have already filed a complaint for this company.',
                  style: const TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : _buildComplaintItem(
                  title: 'Complaint about $companyName',
                  onTap: () {
                    if (user.isGuest) {
                      showAuthRequiredDialog();
                    } else {
                      Get.back();
                      Get.toNamed(
                        Routes.complaint,
                        arguments: {
                          'id': companyId,
                          'isCompany': true,
                          'title': companyName,
                        },
                      );
                    }
                  },
                ),
          const SizedBox(height: 24),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

Widget _buildComplaintItem({
  required String title,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.pureWhite,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.pureWhite,
            size: 16,
          ),
        ],
      ),
    ),
  );
}
