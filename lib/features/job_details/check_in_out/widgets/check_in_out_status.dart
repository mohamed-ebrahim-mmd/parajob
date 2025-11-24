import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/job_details/check_in_out/check_in_out_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';

import '../../../../res/app_asset_paths.dart';
import 'circular_time_progress.dart';

class CheckInOutStatus extends StatelessWidget {
  final controller = Get.find<CheckInOutController>();

  CheckInOutStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.hasAttendance.value == false) {
        return Center(
          child: Image.asset(
            AppAssetPaths.barcodeScan,
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
        );
      } else if (controller.checkInStatus.value == true &&
          controller.checkOutStatus.value == false) {
        return _statusCircle('checked_in'.tr, Icons.check_circle);
      } else if (controller.checkOutStatus.value == true) {
        return _statusCircle('checked_out'.tr, Icons.check);
      } else {
        return Center(
          child: CheckInOutCircularProgress(
            from: controller.activeCheckInOutHistory.value?.job?.from,
            to: controller.activeCheckInOutHistory.value?.job?.to,
            checkInAt: controller.activeCheckInOutHistory.value?.checkInAt,
          ),
        );
      }
    });
  }

  Widget _statusCircle(String label, IconData icon) {
    return Center(
      child: Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(color: AppColors.greenLeaf, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssetPaths.checkIcon2,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.greenLeaf,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
