import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

Future<void> showEditPhotoBottomSheet(
  BuildContext context,
  ProfileController controller,
) async {
  await Get.bottomSheet(
    enterBottomSheetDuration: Duration(milliseconds: 50), // faster
    Container(
      padding: EdgeInsets.all(context.wPct(5)),
      decoration: BoxDecoration(
        color: AppColors.dialogBackgroundDark,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.wPct(6)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // button
          context.hBox(2),
          FilledButton(
            onPressed: () async {
              controller.uploadFile(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.whiteSoft5,
            ),
            child: Text("choose_photo".tr),
          ),
          context.hBox(2),
          FilledButton(
            onPressed: () async {
              controller.uploadFile(context, fromCamera: true);
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.whiteSoft5,
            ),
            child: Text("take_photo".tr),
          ),
          context.hBox(2),

          FilledButton(
            onPressed: () {
              controller.deleteUserPic(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.whiteSoft5,
            ),
            child: Text(
              "remove_photo".tr,
              style: TextStyle(color: AppColors.coralRed),
            ),
          ),
          context.hBox(2),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}
