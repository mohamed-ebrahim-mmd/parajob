/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-12 2:58 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:para_job/features/main_navigator/widgets/user_img.dart';
import 'package:para_job/features/main_navigator/main_navigator_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';
import 'package:para_job/res/app_asset_paths.dart';

class MainNavigatorScreen extends StatelessWidget {
  final MainNavigatorController controller = Get.put(MainNavigatorController());
  final isGuest = Get.find<UserController>().isGuest;

  MainNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: controller.tab.value,
          children: controller.pages,
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.all(
              TextStyle(
                fontSize: context.wPct(3),
              ), // Set your desired font size here
            ),
          ),
          child: NavigationBar(
            elevation: 3,
            backgroundColor: Colors.black,
            selectedIndex: controller.tab.value,
            onDestinationSelected: (value) {
              controller.updateTab(context, value);
            },
            indicatorColor: Colors.transparent,
            // Change this color
            destinations: [
              NavigationDestination(
                icon: SvgPicture.asset(AppAssetPaths.unselectedHomeAppNavIcon),
                selectedIcon: SvgPicture.asset(
                  AppAssetPaths.selectedHomeAppNavIcon,
                ),
                label: 'nav_home'.tr,
              ),
              NavigationDestination(
                icon: SvgPicture.asset(AppAssetPaths.unselectedJobsAppNavIcon),
                selectedIcon: SvgPicture.asset(
                  AppAssetPaths.selectedJobsAppNavIcon,
                ),
                label: 'nav_jobs'.tr,
              ),
              NavigationDestination(
                icon: SvgPicture.asset(
                  AppAssetPaths.unselectedNotificationsAppNavIcon,
                ),
                selectedIcon: SvgPicture.asset(
                  AppAssetPaths.selectedNotificationsAppNavIcon,
                ),
                label: 'nav_notifications'.tr,
              ),
              NavigationDestination(
                icon: controller.userController.isGuest
                    ? Icon(Icons.person_outline, size: context.hPct(4))
                    : UserImg(
                        profilePic:
                            controller.userController.user?.profilePicture,
                      ),
                selectedIcon: controller.userController.isGuest
                    ? Icon(
                        Icons.person_outline,
                        size: context.hPct(4),
                        color: AppColors.aquaTeal,
                      )
                    : UserImg(
                        isSelected: true,
                        profilePic:
                            controller.userController.user?.profilePicture,
                      ),

                label: 'nav_profile'.tr,
              ),
            ],
          ),
        ),
      );
    });
  }
}
