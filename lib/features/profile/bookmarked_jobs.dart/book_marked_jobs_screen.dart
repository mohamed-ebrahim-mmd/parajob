//
//  @ Header: @Author: mary.mark@moselaymd.com |

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/features/profile/bookmarked_jobs.dart/book_marked_jobs_controller.dart';
import 'package:para_job/packages/api_client/src/models/responses/job.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/job_card.dart';

class BookMarkedJobsScreen extends StatelessWidget {
  BookMarkedJobsScreen({super.key});

  final controller = Get.put(BookmarkedJobsController());

  @override
  Widget build(BuildContext screenContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('saved_jobs_title'.tr),
        surfaceTintColor: AppColors.charcoalBlack,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenContext.wPct(5)),
        child: PagingListener<int, Job>(
          controller: controller.pagingController,
          builder: (context, state, fetchNextPage) => PagedListView<int, Job>(
            state: state,
            fetchNextPage: fetchNextPage,
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, item, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: context.hPct(1)),
                child: JobCard(
                  onBookmarkTap: () {
                    controller.removeBookmark(item.id ?? 0, screenContext);
                  },
                  job: item,
                  onTap: () {
                    Get.toNamed(Routes.jobDetails, arguments: item.id);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
