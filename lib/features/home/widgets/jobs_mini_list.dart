import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/home_controller.dart';
import 'package:para_job/features/home/widgets/common_showcase_tooltip.dart';
import 'package:para_job/features/home/widgets/reactive_job_card.dart';
import 'package:para_job/packages/api_client/src/enums/job_category_enum.dart'
    show JobCategory;
import 'package:para_job/packages/api_client/src/models/responses/job.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:showcaseview/showcaseview.dart';

import 'home_department_chips.dart';

class JobsMiniList extends StatelessWidget {
  final List<Job> jobs;
  final String title;
  final controller = Get.find<HomeController>();

  bool get isFlexible => title == 'flexible_jobs'.tr;

  JobsMiniList({super.key, required this.jobs, required this.title});

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
            Showcase.withWidget(
              key: isFlexible ? controller.thirdKey : controller.lastKey,
              onBarrierClick: () => controller.goDismiss(),
              tooltipPosition: TooltipPosition.bottom,
              container: SizedBox(
                width: context.w,
                child: Center(
                  child: CommonShowcaseTooltip(
                    description: isFlexible
                        ? "flexible_job_show_case".tr
                        : "non_flexible_job_show_case".tr,
                    isLast: !isFlexible,
                    currentStep: isFlexible ? 1 : 2,
                  ),
                ),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: context.wPct(4.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => controller.openJobsScreen(
                category: isFlexible
                    ? JobCategory.flexible.value
                    : JobCategory.nonFlexible.value,
                title: title,
              ),
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
        context.hBox(1),
        HomeDepartmentChips(
          onSelected: (id) {
            controller.openJobsScreen(
              category: isFlexible
                  ? JobCategory.flexible.value
                  : JobCategory.nonFlexible.value,
              title: title,
              id: id,
            );
          },
        ),
        context.hBox(2),
        // Vertical List of Job Cards
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: jobs.length,
          separatorBuilder: (_, __) => context.hBox(2),
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
