import 'package:flutter/material.dart';
import 'package:para_job/packages/api_client/src/models/responses/company.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/job_card.dart';
// Import your own helpers:

class ActiveJobsList extends StatelessWidget {
  final Company company;

  const ActiveJobsList({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    if (company.activeJobs != null && company.activeJobs!.isNotEmpty) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: company.activeJobs!.length,
        separatorBuilder: (_, __) => context.hBox(1),
        itemBuilder: (context, index) {
          final job = company.activeJobs![index];
          return JobCard(job: job);
        },
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.hPct(2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.work_outline,
              color: AppColors.white40,
              size: context.hPct(2.5),
            ),
            context.wBox(2),
            Text(
              "No active jobs available at the moment.",
              style: TextStyle(
                fontSize: context.wPct(4),
                color: AppColors.white40,
              ),
            ),
          ],
        ),
      );
    }
  }
}
