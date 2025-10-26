/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-14 5:57 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/user_profilee_controller.dart';
import 'package:para_job/features/profile/widgets/job_history_list.dart';
import 'package:para_job/features/profile/widgets/profile_info.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';

import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(// backgroundColor: Colors.white, // or your preferred color
 
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.menu)),],),
      body: Center(
        child: Obx(() {
          switch (controller.profileCallState.value) {
            case ApiCallState.loading:
              return Container(
                alignment: Alignment.center,
                height: context.hPct(60),
                child: const CircularProgressIndicator(),
              );

            case ApiCallState.success:
              final profileData = controller.profileData!.data;

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
                    ],
                  ),
                ),
              );

            case ApiCallState.failure:
              return ErrorScreen(
                height: context.hPct(60),
                onPressed: () {
                  controller.fetchProfileDetails("token");
                },
              );
          }
        }),
      ),
    );
  }
}
