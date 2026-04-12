import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/src/models/models.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart'
    show Routes;
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/job_card.dart';

class JobHistoryList extends StatelessWidget {
  final List<Job> jobHistory;
  final String? title;
  final String emptyMessage;
  final VoidCallback? onSeeAll;
  final bool showBookmarkIcon;

  const JobHistoryList({
    super.key,
    required this.jobHistory,
    this.title,
    required this.emptyMessage,
    this.onSeeAll,
    required this.showBookmarkIcon,
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
            padding: EdgeInsets.zero,
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
                onTap: () {
                  Get.toNamed(Routes.jobDetails, arguments: job.id);
                },
                job: job,
                showBookmarkIcon: showBookmarkIcon,
              );
            },
          ),
        ),
        context.hBox(1),
        Visibility(
          visible: jobHistory.isNotEmpty,

          child: Align(
            alignment: AlignmentGeometry.center,
            child: TextButton(
              onPressed: onSeeAll,
              child: Row(
                textDirection: TextDirection.ltr,

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
                  context.wBox(.5),
                  Icon(
                    Icons.keyboard_double_arrow_right_rounded,
                    color: AppColors.pureWhite,
                  ),
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
