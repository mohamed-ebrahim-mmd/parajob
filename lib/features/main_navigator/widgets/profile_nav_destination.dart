//Mary Mark ||  mary.mark@moselaymd.com || Mon Nov 17 2025 10:45:34

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/main_navigator/main_navigator_controller.dart';
import 'package:para_job/features/main_navigator/widgets/user_img.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class ProfileNavDestination extends StatelessWidget {
  //final MainNavigatorController controller;
  final controller = Get.find<MainNavigatorController>();
  ProfileNavDestination({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return NavigationDestination(
        icon: controller.userController.isGuest
            ? Icon(Icons.person_2_outlined, size: context.hPct(2.3))
            : UserImg(profilePic: controller.userProfilePic.value),
        selectedIcon: controller.userController.isGuest
            ? Icon(
                Icons.person_outline,
                size: context.hPct(3),
                color: AppColors.aquaTeal,
              )
            : UserImg(
                isSelected: true,
                profilePic: controller.userProfilePic.value,
              ),

        label: 'nav_profile'.tr,
      );
    });
  }
}
