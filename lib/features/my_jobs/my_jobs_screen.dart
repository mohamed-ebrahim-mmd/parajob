import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/my_jobs/my_job_controller.dart';
import 'package:para_job/features/my_jobs/widgets/applied_job_list.dart';
import 'package:para_job/features/my_jobs/widgets/approved_job_list.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../../packages/themeing/app_colors.dart';

class MyJobsScreen extends StatelessWidget {
  MyJobsScreen({super.key});

  final myJobsController = Get.put(MyJobsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.hBox(2),

            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      // Gives the shadow room to breathe only at the bottom
                      indicatorPadding: EdgeInsets.only(top: context.hPct(5.2)),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.aquaTeal,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.aquaTeal.withValues(alpha: 0.4),
                            blurRadius: 6, // Small blur for a tight glow
                            spreadRadius: 0, // No spread to keep it contained
                            offset: const Offset(0, 1), // Slight downward shift
                          ),
                        ],
                      ),
                      dividerHeight: 0,
                      indicatorSize: TabBarIndicatorSize.label,
                      // Makes the line width match the text
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.wPct(5),
                        color: AppColors.pureWhite,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: context.wPct(4.5),
                        color: AppColors.pureWhite.withValues(alpha: .7),
                      ),
                      // 👈 your color here
                      tabs: [
                        Tab(text: 'my_jobs_tab_applied'.tr),
                        Tab(text: 'my_jobs_tab_approved'.tr),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [AppliedJobList(), ApprovedJobList()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
