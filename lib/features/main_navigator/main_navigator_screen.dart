/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-12 2:58 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:para_job/features/main_navigator/main_navigator_controller.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';
import 'package:para_job/res/app_asset_paths.dart';

class MainNavigatorScreen extends StatelessWidget {
  final MainNavigatorController controller = Get.put(MainNavigatorController());
  final isGuest = Get.find<UserController>().isGuest;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var tabIndex = controller.tab.value;
      return Scaffold(
        /*
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: tabIndex == 0 ? AppBarLogo() : null,
          // Remove shadow
          title: tabIndex == 0
              ? TappableSearchBar()
              : Text(
                  overflow: TextOverflow.visible,
                  softWrap: true,

                  controller.appBarTitles[tabIndex].tr, // Dynamic title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: context.hPct(4),
                    fontWeight: FontWeight.bold,
                    color: context.theme.colorScheme.primaryContainer,
                  ),
                ),
          actions: tabIndex == 0
              ? [NotificationIconButton(), context.wBox(1)]
              : null,
        ),
*/
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
            backgroundColor: Colors.transparent,
            selectedIndex: controller.tab.value,
            onDestinationSelected: (value) {
              controller.updateTab(context, value);
            },
            indicatorColor: context.theme.primaryColor,
            // Change this color
            destinations: [
              NavigationDestination(
                icon: SvgPicture.asset(AppAssetPaths.unselectedHomeAppNavIcon),
                selectedIcon: SvgPicture.asset(
                  AppAssetPaths.selectedHomeAppNavIcon,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(AppAssetPaths.unselectedJobsAppNavIcon),
                selectedIcon: SvgPicture.asset(
                  AppAssetPaths.selectedJobsAppNavIcon,
                ),
                label: 'Favorites',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(
                  AppAssetPaths.unselectedNotificationsAppNavIcon,
                ),
                selectedIcon: SvgPicture.asset(
                  AppAssetPaths.selectedNotificationsAppNavIcon,
                ),
                label: 'Categories',
              ),
              NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      );
    });
  }
}
