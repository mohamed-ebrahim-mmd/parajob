/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-14 5:57 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/home_controller.dart';
import 'package:para_job/features/home/widgets/hot_jobs_mini_list.dart';
import 'package:para_job/features/home/widgets/jobs_mini_list.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart'
    show ApiCallState;
import 'package:para_job/packages/api_client/src/enums/job_category_enum.dart'
    show JobCategory;
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class HomeScreen extends StatelessWidget {
  final user = Get.find<UserController>().user;
  final controller = Get.put(HomeController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.hBox(2),
              Text(
                'Welcome, ${user?.name ?? "Guest"}',
                style: TextStyle(
                  fontSize: context.wPct(4),
                  color: const Color(0xFFCCCCCC),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Discover jobs',
                style: TextStyle(
                  fontSize: context.wPct(7),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(2),
              TextField(
                readOnly: true, // 👈 user can't type
                onTap: () {
                  Get.toNamed("${Routes.mainNavigator}${Routes.searchJob}");
                },
                decoration: InputDecoration(
                  hintText: 'Search jobs, companies..',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.tune),
                  filled: false,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.softWhite70,
                      // width:context.wPct(4),
                    ),
                    borderRadius: BorderRadius.circular(context.wPct(4)),
                  ),
                ),
              ),
              context.hBox(2),
              Obx(() {
                switch (controller.homeCallState.value) {
                  case ApiCallState.loading:
                    return Container(
                      alignment: Alignment.center,
                      height: context.hPct(60),
                      child: CircularProgressIndicator(),
                    );
                  case ApiCallState.success:
                    final hotJobsList = controller.homeData!.data.first.hotJobs;
                    final nonFlexibleJobs =
                        controller.homeData!.data.first.nonFlexibleJobs;

                    final flexibleJobsList =
                        controller.homeData!.data.first.flexibleJobs;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HotJobsMiniList(
                          jobs: hotJobsList,
                          onSeeAll: () {
                            Get.toNamed(
                              "${Routes.mainNavigator}${Routes.jobs}",
                              arguments: {
                                "title": "Hot Jobs",
                                "category": JobCategory.hotJob.value,
                              },
                            );
                          },
                        ),
                        context.hBox(2),
                        JobsMiniList(
                          jobs: flexibleJobsList,
                          title: "Flexible Jobs",
                          onSeeAll: () {
                            Get.toNamed(
                              "${Routes.mainNavigator}${Routes.jobs}",
                              arguments: {
                                "title": "Flexible Jobs",
                                "category": JobCategory.flexible.value,
                              },
                            );
                          },
                        ),
                        context.hBox(2),
                        JobsMiniList(
                          jobs: nonFlexibleJobs,
                          title: "Non-Flexible Jobs",
                          onSeeAll: () {
                            Get.toNamed(
                              "${Routes.mainNavigator}${Routes.jobs}",
                              arguments: {
                                "title": "Non-Flexible Jobs",
                                "category": JobCategory.nonFlexible.value,
                              },
                            );
                          },
                        ),
                        context.hBox(2),
                      ],
                    );
                  case ApiCallState.failure:
                    return ErrorScreen(
                      height: context.hPct(60),
                      onPressed: () {
                        controller.fetchHomeJobs();
                      },
                    );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
