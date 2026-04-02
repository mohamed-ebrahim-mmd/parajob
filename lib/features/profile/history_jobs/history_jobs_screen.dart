//Mary Mark ||  mary.mark@moselaymd.com || Mon Nov 10 2025 16:18:54

//
//  @ Header: @Author: mary.mark@moselaymd.com |

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/features/my_jobs/widgets/my_job_card.dart';
import 'package:para_job/features/profile/history_jobs/history_jobs_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class HistoryJobsScreen extends StatelessWidget {
  HistoryJobsScreen({super.key});

  final controller = Get.put(HistoryJobsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.charcoalBlack,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'profile_job_history_title'.tr,
              style: TextStyle(
                fontSize: context.wPct(4.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: PagingListener<int, MyJob>(
                controller: controller.pagingController,
                builder: (context, state, fetchNextPage) =>
                    PagedListView<int, MyJob>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      builderDelegate: PagedChildBuilderDelegate(
                        itemBuilder: (context, item, index) => Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: context.hPct(1),
                          ),
                          child: MyJobCard(job: item, isHistoryJobs: true),
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
