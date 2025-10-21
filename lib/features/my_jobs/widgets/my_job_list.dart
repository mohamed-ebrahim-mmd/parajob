import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:para_job/features/my_jobs/widgets/my_job_card.dart';
import 'package:para_job/packages/api_client/src/service/api_client_instance.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import '../../../packages/api_client/src/enums/job_application_status.dart';
import '../../../packages/api_client/src/models/responses/my_job.dart';
import '../../../packages/themeing/app_colors.dart';
import '../../../packages/themeing/media_query_values.dart';

class MyJobsList extends StatefulWidget {
  final JobApplicationStatus? status;
  final bool highlighted;
  final String title;

  const MyJobsList({
    super.key,
    this.status,
    required this.highlighted,
    required this.title,
  });

  @override
  State<MyJobsList> createState() => _MyJobsListState();
}

class _MyJobsListState extends State<MyJobsList> {
  final token = Get.find<UserController>().token!;
  late final pagingController = PagingController<int, MyJob>(
    getNextPageKey: (state) =>
        state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) {
      return fetchMyJobsPage(
        status: widget.status,
        page: pageKey,
        token: token,
      );
    },
  );

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagingListener(
      controller: pagingController,
      builder: (context, state, fetchNextPage) {
        final allItems = state.pages?.expand((e) => e).toList() ?? [];
        if (allItems.isNotEmpty) {
          final groupedJobs = groupJobsByMonth(allItems);
          if (groupedJobs.isEmpty) {
            return Center(
              child: Text(
                "No jobs found",
                style: TextStyle(
                  color: AppColors.lightGrey,
                  fontSize: context.wPct(4),
                ),
              ),
            );
          }
        }
        return PagedListView<int, MyJob>(
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: PagedChildBuilderDelegate<MyJob>(
            firstPageProgressIndicatorBuilder: (_) =>
                Center(child: CircularProgressIndicator()),
            newPageProgressIndicatorBuilder: (_) =>
                Center(child: CircularProgressIndicator()),
            noItemsFoundIndicatorBuilder: (_) => Center(
              child: Text(
                "No jobs found",
                style: TextStyle(fontSize: context.wPct(4)),
              ),
            ),
            itemBuilder: (context, item, index) {
              final allItems = state.pages?.expand((e) => e).toList() ?? [];
              List<Widget> children = [];
              if (index == 0) {
                children.add(
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: context.hPct(3)),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: context.wPct(3),
                        fontWeight: FontWeight.w400,
                        color: AppColors.softWhite70,
                      ),
                    ),
                  ),
                );
              }
              final date = DateTime.tryParse(item.applicationDate);
              final monthKey = date != null
                  ? DateFormat('MMMM yyyy').format(date)
                  : '';
              if (index == 0 ||
                  monthKey !=
                      DateFormat('MMMM yyyy').format(
                        DateTime.tryParse(
                              allItems[index - 1].applicationDate,
                            ) ??
                            date!,
                      )) {
                children.add(
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: context.hPct(1.5)),
                    child: Text(
                      monthKey,
                      style: TextStyle(
                        fontSize: context.wPct(3.5),
                        fontWeight: FontWeight.w500,
                        color: AppColors.softWhite70,
                      ),
                    ),
                  ),
                );
              }
              children.add(
                Padding(
                  padding: EdgeInsets.only(bottom: context.hPct(2)),
                  child: MyJobCard(job: item, highlighted: widget.highlighted),
                ),
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              );
            },
          ),
        );
      },
    );
  }
}

Map<String, List<dynamic>> groupJobsByMonth(List<dynamic> jobs) {
  final Map<String, List<dynamic>> grouped = {};
  for (var job in jobs) {
    final date = DateTime.tryParse(job.applicationDate);
    if (date == null) continue;
    final monthKey = DateFormat('MMMM yyyy').format(date);
    if (!grouped.containsKey(monthKey)) {
      grouped[monthKey] = [];
    }
    grouped[monthKey]!.add(job);
  }
  return grouped;
}

Future<List<MyJob>> fetchMyJobsPage({
  JobApplicationStatus? status,
  int page = 1,
  required String token,
}) async {
  final response = await apiClient.fetchMyJobs(
    status: status?.value ?? "",
    page: page,
    token: token,
  );

  return response.data;
}
