/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-14 5:57 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/features/profile/widgets/job_history_list.dart';
import 'package:para_job/features/profile/widgets/profile_info.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.charcoalBlack,
        actions: [
          Obx(() {
            if (controller.profileCallState.value == ApiCallState.success) {
              return IconButton(onPressed: () {
                 Get.toNamed("${Routes.mainNavigator}${Routes.more}");
              }, icon: const Icon(Icons.menu));
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
                    horizontal: context.wPct(5),
                  ),
                  child: Column(
                    children: [
                      //user info
                      UserProfileInfo(profileData: profileData),

                      //job history list
                      context.hBox(3),
                      JobHistoryList(jobHistory: profileData.jobs ?? []),
                      //saved jobs list
                      context.hBox(3),
                      JobHistoryList(
                        jobHistory: profileData.savedJobs ?? [],
                        title: "Saved Jobs",
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
