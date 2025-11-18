/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-12 2:58 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:para_job/features/main_navigator/widgets/profile_nav_destination.dart';
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
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
              states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return TextStyle(
                  fontSize: context.wPct(3),
                  color: AppColors.aquaTeal, // Color for selected text
                );
              }
              return TextStyle(
                fontSize: context.wPct(3),
                color: Colors.white, // Color for unselected text
              );
            }),
          ),
          child: NavigationBar(
            height: context.hPct(6.2),
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
                icon: SvgPicture.asset(
                  AppAssetPaths.unselectedHomeAppNavIcon,
                  height: context.hPct(3),
                  width: context.wPct(3),
                ),
                selectedIcon: SvgPicture.asset(
                  AppAssetPaths.selectedHomeAppNavIcon,
                  height: context.hPct(3),
                  width: context.wPct(3),
                ),
                label: 'nav_home'.tr,
              ),
              NavigationDestination(
                icon: SvgPicture.asset(
                  AppAssetPaths.unselectedJobsAppNavIcon,
                  height: context.hPct(3),
                  width: context.wPct(3),
                ),
                selectedIcon: SvgPicture.asset(
                  AppAssetPaths.selectedJobsAppNavIcon,
                  height: context.hPct(3),
                  width: context.wPct(3),
                ),
                label: 'nav_jobs'.tr,
              ),
              NavigationDestination(
                icon: SvgPicture.asset(
                  AppAssetPaths.unselectedNotificationsAppNavIcon,
                  height: context.hPct(3),
                  width: context.wPct(3),
                ),
                selectedIcon: SvgPicture.asset(
                  AppAssetPaths.selectedNotificationsAppNavIcon,
                  height: context.hPct(3),
                  width: context.wPct(3),
                ),
                label: 'nav_notifications'.tr,
              ),
              ProfileNavDestination(controller: controller),
            ],
          ),
        ),
      );
    });
  }
}
