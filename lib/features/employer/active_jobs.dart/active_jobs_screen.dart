/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com |
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/packages/api_client/src/models/responses/job.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/job_card.dart';

import 'active_jobs_controller.dart';

class ActiveJobsScreen extends StatelessWidget {
  final int companyId = Get.arguments['id'];

  ActiveJobsScreen({super.key});

  late final controller = Get.put(ActiveJobsController(companyId: companyId));

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
              'active_jobs'.tr,
              style: TextStyle(
                fontSize: context.wPct(6),
                fontWeight: FontWeight.w600,
                color: AppColors.pureWhite,
              ),
            ),
            context.hBox(1),
            Expanded(
              child: PagingListener<int, Job>(
                controller: controller.pagingController,
                builder: (context, state, fetchNextPage) =>
                    PagedListView<int, Job>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      builderDelegate: PagedChildBuilderDelegate(
                        itemBuilder: (context, item, index) => Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: context.hPct(1),
                          ),
                          child: JobCard(
                            showBookmarkIcon: false,
                            job: item,
                            onTap: () {
                              Get.toNamed(
                                Routes.jobDetails,
                                arguments: item.id,
                                preventDuplicates: false,
                              );
                            },
                          ),
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
