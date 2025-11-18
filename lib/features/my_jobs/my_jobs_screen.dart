import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/my_jobs/widgets/my_job_list.dart';
import 'package:para_job/packages/api_client/src/enums/job_application_status.dart'
    show JobApplicationStatus;
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../../packages/themeing/app_colors.dart';

class MyJobsScreen extends StatelessWidget {
  const MyJobsScreen({super.key});

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
                      dividerHeight: 0,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: context.wPct(3.5),
                        color: AppColors.pureWhite,
                      ),
                      tabs: [
                        Tab(text: 'my_jobs_tab_applied'.tr),
                        Tab(text: 'my_jobs_tab_approved'.tr),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          MyJobsList(
                            highlighted: false,
                            title: 'my_jobs_applied_description'.tr,
                          ),
                          MyJobsList(
                            status: JobApplicationStatus.accepted,
                            highlighted: true,
                            title: 'my_jobs_approved_description'.tr,
                          ),
                        ],
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
