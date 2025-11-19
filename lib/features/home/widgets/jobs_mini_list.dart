import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/home_controller.dart';
import 'package:para_job/features/home/widgets/reactive_job_card.dart';
import 'package:para_job/packages/api_client/src/models/responses/job.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:showcaseview/showcaseview.dart';

class JobsMiniList extends StatelessWidget {
  final List<Job> jobs;
  final VoidCallback? onSeeAll;
  final String title;
  final controller = Get.find<HomeController>();

  JobsMiniList({
    super.key,
    required this.jobs,
    this.onSeeAll,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Showcase(
              key: title == 'flexible_jobs'.tr
                  ? controller.thirdKey
                  : controller.lastKey,
              description: title == 'flexible_jobs'.tr
                  ? "Work on your schedule—choose hours and locations that suit you."
                  : "Structured roles with fixed hours and responsibilities—perfect for steady routines.",
              onBarrierClick: () => controller.goDismiss(),

              tooltipBackgroundColor: AppColors.midnightBlue,
              textColor: AppColors.pureWhite,
              descriptionTextAlign: TextAlign.center,
              tooltipPadding: EdgeInsets.all(context.wPct(6)),
              tooltipBorderRadius: BorderRadius.circular(context.wPct(3)),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: context.wPct(4.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                "see_all".tr,
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        context.hBox(2),
        // Vertical List of Job Cards
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: jobs.length,
          separatorBuilder: (_, __) => context.hBox(3),
          itemBuilder: (context, index) {
            final job = jobs[index];
            return ReactiveJobCard(
              job: job,
              onBookmarkTap: () {
                Get.find<HomeController>().handleBookmarkTap(job, context);
              },
              onTap: () {
                Get.toNamed(Routes.jobDetails, arguments: job.id);
              },
            );
          },
        ),
      ],
    );
  }
}
