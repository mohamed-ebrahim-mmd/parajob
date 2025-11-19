/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com |
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/packages/api_client/src/models/responses/job.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/job_card.dart';

import 'active_jobs_controller.dart';

class ActiveJobsScreen extends StatelessWidget {
  final int companyId;

  ActiveJobsScreen({super.key}) : companyId = Get.arguments['id'];
  late final controller = Get.put(ActiveJobsController(companyId: companyId));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('active_jobs'.tr),
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
        child: PagingListener<int, Job>(
          controller: controller.pagingController,
          builder: (context, state, fetchNextPage) => PagedListView<int, Job>(
            state: state,
            fetchNextPage: fetchNextPage,
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, item, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: context.hPct(1)),
                child: JobCard(showBookmarkIcon: false, job: item),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
