import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:para_job/features/my_jobs/my_jobs_utils.dart';
import 'package:para_job/features/my_jobs/widgets/my_job_card.dart';
import 'package:para_job/features/my_jobs/widgets/sign_contract_job_dialog.dart';

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
  late final PagingController<int, MyJob> pagingController;

  @override
  void initState() {
    super.initState();
    pagingController = initPagingController(widget.status);
  }

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
        return PagedListView<int, MyJob>(
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: PagedChildBuilderDelegate<MyJob>(
            noItemsFoundIndicatorBuilder: (_) => Center(
              child: Text(
                'my_job_no_jobs_found'.tr,
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
                  child: MyJobCard(
                    job: item,
                    highlighted: widget.highlighted,
                    onTap: widget.highlighted && item.isSignedContract == 0
                        ? () {
                            signContractJobDialog(item, pagingController);
                          }
                        : null,
                  ),
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
