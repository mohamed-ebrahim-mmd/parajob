import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/features/home/jobs/jobs_controller.dart';
import 'package:para_job/features/home/widgets/department_chips.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/api_client/src/enums/job_category_enum.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart'
    show ErrorScreen;
import 'package:para_job/packages/ui_components/job_card.dart';

class JobsScreen extends StatelessWidget {
  JobsScreen({super.key});

  final args = Get.arguments as Map<String, dynamic>?;
  late final title = args?['title'] ?? '-';
  late final category = args?['category'];
  late final controller = Get.put(JobsController(jobCategory: category));

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
        padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row
            Row(
              children: [
                if (category == JobCategory.hotJob.value)
                  Padding(
                    padding: EdgeInsets.only(right: context.wPct(1)),
                    child: Icon(
                      Icons.local_fire_department,
                      color: Colors.red,
                      size: context.hPct(3),
                    ),
                  ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: context.wPct(4.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            context.hBox(2),
            Obx(() {
              switch (controller.departmentCallState.value) {
                case ApiCallState.loading:
                  return Container(
                    alignment: Alignment.center,
                    height: context.hPct(70),
                    child: const CircularProgressIndicator(),
                  );
                case ApiCallState.success:
                  return Expanded(
                    child: Column(
                      children: [
                        DepartmentChips(),
                        Expanded(
                          child: PagingListener<int, Job>(
                            controller: controller.pagingController,
                            builder: (context, state, fetchNextPage) =>
                                PagedListView<int, Job>(
                                  state: state,
                                  fetchNextPage: fetchNextPage,
                                  builderDelegate: PagedChildBuilderDelegate(
                                    itemBuilder: (context, item, index) =>
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: context.hPct(1),
                                          ),
                                          child: JobCard(
                                            onBookmarkTap: () {
                                              controller.handleBookmarkTap(
                                                item,
                                                context,
                                              );
                                            },
                                            job: item,
                                            onTap: () {
                                              Get.toNamed(
                                                Routes.jobDetails,
                                                arguments: item.id,
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
                  );
                case ApiCallState.failure:
                  return ErrorScreen(
                    height: context.hPct(70),
                    onPressed: () {
                      controller.fetchDepartments();
                    },
                  );
              }
            }),
          ],
        ),
      ),
    );
  }
}
