
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        color: AppColors.midnightBlue,
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
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.whiteSoft5,
            ),
            child: Text("Choose photo"),
          ),
          context.hBox(2),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.whiteSoft5,
            ),
            child: Text("Take photo"),
          ),
          context.hBox(2),

          FilledButton(
            onPressed: () {
              controller.deleteUserPic(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.whiteSoft5,
            ),
            child: Text("Remove photo",style: TextStyle(color: AppColors.coralRed),),
          ),
          context.hBox(2),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}
