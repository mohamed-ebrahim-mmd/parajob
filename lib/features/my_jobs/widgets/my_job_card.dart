import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/src/enums/job_application_status.dart';
import 'package:para_job/packages/api_client/src/models/responses/my_job.dart'
    show MyJob;
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../../../packages/ui_components/app_network_image.dart';

class MyJobCard extends StatelessWidget {
  final MyJob job;
  final bool highlighted;
  final VoidCallback? onTap;
  final bool? isHistoryJobs;
  const MyJobCard({
    super.key,
    required this.job,
    this.highlighted = false,
    this.isHistoryJobs,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.wPct(3.5)),
      child: Container(
        padding: EdgeInsets.all(context.wPct(4)),

        margin: EdgeInsets.symmetric(horizontal: context.wPct(1.5)),
        decoration: BoxDecoration(
          color: AppColors.darkCharcoal,
          borderRadius: BorderRadius.circular(context.wPct(3.5)),
          border: highlighted
              ? Border.all(color: AppColors.aquaTeal, width: context.wPct(0.3))
              : null,
          boxShadow: highlighted
              ? [
                  BoxShadow(
                    color: AppColors.aquaTealShadow.withValues(alpha: 0.3),
                    blurRadius: context.wPct(2),
                    spreadRadius: -2,
                    offset: Offset(0, context.wPct(2)),
                  ),
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(context.wPct(2)),
              child: AppNetworkImage(
                url: job.company.logo ?? '',
                width: context.wPct(12),
                height: context.wPct(12),
                fit: BoxFit.contain,
                borderRadius: BorderRadius.circular(context.wPct(2)),
              ),
            ),
            context.wBox(2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: TextStyle(
                      fontSize: context.wPct(4),
                      fontWeight: FontWeight.w600,
                      color: highlighted
                          ? Colors.white
                          : AppColors.lightSilverGray,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  context.hBox(1),

                  Text(
                    job.company.name ?? "",
                    style: TextStyle(
                      fontSize: context.wPct(3.2),
                      fontWeight: FontWeight.w600,
                      color: highlighted
                          ? Colors.white70
                          : AppColors.lightSilverGray,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            context.wBox(2),
            isHistoryJobs == null
                ? Text(
                    !highlighted
                        ? job.applicationStatus.displayName
                        : job.isSignedContract == 0
                        ? 'my_job_contract_pending'.tr
                        : 'my_job_contract_signed'.tr,
                    style: TextStyle(
                      color: highlighted
                          ? AppColors.aquaTeal
                          : _getStatusColor(job.applicationStatus),
                      fontWeight: FontWeight.bold,
                      fontSize: context.wPct(3.5),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(JobApplicationStatus status) {
    switch (status) {
      case JobApplicationStatus.accepted:
        return AppColors.accepted;
      case JobApplicationStatus.shortlisted:
        return AppColors.shortlisted;
      case JobApplicationStatus.rejected:
        return AppColors.rejected;
      case JobApplicationStatus.interviewScheduled:
        return AppColors.interviewScheduled;
      case JobApplicationStatus.pending:
        return AppColors.pending;
      //pending
    }
  }
}
