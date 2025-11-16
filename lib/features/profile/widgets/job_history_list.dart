import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/src/models/models.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/job_card.dart';

class JobHistoryList extends StatelessWidget {
  final List<Job> jobHistory;
  final String? title;
  final String emptyMessage;
  final VoidCallback? onSeeAll;

  const JobHistoryList({
    super.key,
    required this.jobHistory,
    this.title,
    required this.emptyMessage,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          title ?? 'profile_job_history_title'.tr,
          style: TextStyle(
            fontSize: context.wPct(4.5),
            fontWeight: FontWeight.bold,
          ),
        ),
        context.hBox(1.5),
        // Job List
        Visibility(
          visible: jobHistory.isNotEmpty,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: jobHistory.length,
            separatorBuilder: (_, __) => context.hBox(2),
            itemBuilder: (context, index) {
              final job = jobHistory[index];
              return JobCard(
                onBookmarkTap: () {
                  Get.find<ProfileController>().removeBookmark(
                    job.id ?? 0,
                    context,
                  );
                },
                job: job,
                showBookmarkIcon: title == null ? false : true,
              );
            },
          ),
        ),
        Visibility(
          visible: jobHistory.isNotEmpty,

          child: Align(
            alignment: AlignmentGeometry.center,
            child: TextButton(
              onPressed: onSeeAll,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'job_history_view_more'.tr,
                    style: TextStyle(
                      fontSize: context.wPct(3.9),
                      fontWeight: FontWeight.w500,
                      color: AppColors.pureWhite,
                    ),
                  ),

                  Icon(Icons.fast_forward_rounded, color: AppColors.pureWhite),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: jobHistory.isEmpty,
          child: Padding(
            padding: EdgeInsets.all(context.hPct(4.5)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    emptyMessage,
                    style: TextStyle(color: AppColors.lightGray),
                  ),
                  Icon(
                    Icons.do_not_disturb_alt_rounded,
                    color: AppColors.lightGray,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
