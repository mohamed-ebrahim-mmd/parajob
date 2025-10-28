import 'package:flutter/material.dart';
import 'package:para_job/features/my_jobs/widgets/my_job_list.dart';
import 'package:para_job/packages/api_client/src/enums/job_application_status.dart'
    show JobApplicationStatus;
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../../packages/themeing/app_colors.dart';

class MyJobsScreen extends StatelessWidget {
  const MyJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.hPct(2)),
              const Text(
                'My Jobs',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.pureWhite,
                ),
              ),
              SizedBox(height: context.hPct(2)),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        dividerHeight: 0,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.pureWhite,
                        ),
                        tabs: const [
                          Tab(text: 'Applied Jobs'),
                          Tab(text: 'Approved Jobs'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            MyJobsList(
                              status: null,
                              highlighted: false,
                              title:
                                  'The jobs you applied for and still waiting whether to be approved and assigned to you or not.',
                            ),
                            MyJobsList(
                              status: JobApplicationStatus.accepted,
                              highlighted: true,
                              title:
                                  'This category includes all your approved jobs, here you sign your contracts and view your jobs.',
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
      ),
    );
  }
}
