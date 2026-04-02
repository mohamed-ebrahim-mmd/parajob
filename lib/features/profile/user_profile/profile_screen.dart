/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-14 5:57 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/features/profile/widgets/job_history_list.dart';
import 'package:para_job/features/profile/widgets/profile_info.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';
import 'package:para_job/res/app_asset_paths.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: context.wPct(12),
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: context.wPct(4)),
          child: GestureDetector(
            onTap: () {
              // Navigate to balance screen
              controller.navigateToBalanceScreen();
            },
            child: SvgPicture.asset(
              AppAssetPaths.balanceCoinIcon,
              height: context.hPct(4.1),
            ),
          ),
        ),

        surfaceTintColor: AppColors.charcoalBlack,
        actions: [
          Obx(() {
            if (controller.profileCallState.value == ApiCallState.success) {
              return IconButton(
                onPressed: () {
                  Get.toNamed("${Routes.mainNavigator}${Routes.more}");
                },
                icon: Icon(Icons.menu, size: context.hPct(4.1)),
              );
            } else {
              return const SizedBox.shrink(); // empty widget
            }
          }),
        ],
      ),
      body: Center(
        child: Obx(() {
          switch (controller.profileCallState.value) {
            case ApiCallState.loading:
              return Center(child: const CircularProgressIndicator());

            case ApiCallState.success:
              final profileData = controller.profileData!;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: context.defaultPadding,
                  ),
                  child: Column(
                    children: [
                      //user info
                      UserProfileInfo(
                        profileData: profileData,
                        controller: controller,
                      ),

                      //job history list
                      context.hBox(3),
                      JobHistoryList(
                        jobHistory: profileData.jobs ?? [],
                        emptyMessage: 'profile_no_job_history'.tr,
                        title: 'profile_job_history_title'.tr,
                        onSeeAll: controller.onSeeAllHistoryJobs,
                        showBookmarkIcon: false,
                      ),
                      //saved jobs list
                      context.hBox(2.5),
                      JobHistoryList(
                        emptyMessage: 'profile_no_saved_jobs'.tr,
                        jobHistory: profileData.savedJobs ?? [],
                        title: 'profile_saved_jobs_title'.tr,
                        onSeeAll: controller.onSeeAllSavedJobs,
                        showBookmarkIcon: true,
                      ),
                      context.hBox(2),
                    ],
                  ),
                ),
              );

            case ApiCallState.failure:
              return Center(
                child: ErrorScreen(
                  onPressed: () {
                    controller.fetchProfileDetails();
                  },
                ),
              );
          }
        }),
      ),
    );
  }
}
