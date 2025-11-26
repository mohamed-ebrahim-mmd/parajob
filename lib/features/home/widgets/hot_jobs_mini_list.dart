/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-16 10:52 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/home_controller.dart';
import 'package:para_job/features/home/widgets/hot_job_card.dart';
import 'package:para_job/features/home/widgets/start_tutorial_dialog.dart';
import 'package:para_job/packages/api_client/src/models/responses/job.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:showcaseview/showcaseview.dart';

class HotJobsMiniList extends StatelessWidget {
  final List<Job> jobs;
  final VoidCallback? onSeeAll;
  final controller = Get.find<HomeController>();

  HotJobsMiniList({super.key, required this.jobs, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Showcase(
              key: controller.secondKey,
              description:
                  "Premium jobs from major companies or special events. These roles are limited and competitive—apply fast and stand out.",
              onBarrierClick: () => controller.goDismiss(),
              tooltipBackgroundColor: AppColors.midnightBlue,
              textColor: AppColors.pureWhite,
              tooltipPadding: EdgeInsets.all(context.wPct(6)),
              descriptionTextAlign: TextAlign.center,
              tooltipBorderRadius: BorderRadius.circular(context.wPct(3)),
              child: Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.red,
                    size: context.hPct(4),
                  ),
                  context.wBox(2),
                  Text(
                    "hot_jobs".tr,
                    style: TextStyle(
                      fontSize: context.wPct(4.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
        Showcase.withWidget(
          key: controller.firstKey,
          disableBarrierInteraction: true,
          container: StartTutorialDialog(),
          child: context.hBox(2),
        ),

        // // Horizontal List of Job Cards
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Align top
            children: jobs.map((job) {
              return Padding(
                padding: EdgeInsets.only(
                  right: context.wPct(2),
                ), // spacing between items
                child: HotJobCard(
                  job: job,
                  onBookmarkTap: () {
                    Get.find<HomeController>().handleBookmarkTap(job, context);
                  },
                  onTap: () {
                    Get.toNamed(Routes.jobDetails, arguments: job.id);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
