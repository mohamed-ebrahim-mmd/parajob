import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/src/enums/job_application_status.dart';
import 'package:para_job/packages/api_client/src/models/responses/my_job.dart'
    show MyJob;
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/app_network_image.dart'
    show AppNetworkImage;

import '../../../packages/route_manager/controller/routes.dart';

class MyJobCard extends StatelessWidget {
  final MyJob job;
  final bool highlighted;

  const MyJobCard({super.key, required this.job, this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.wPct(4)),
      decoration: BoxDecoration(
        color: AppColors.darkCharcoal,
        borderRadius: BorderRadius.circular(context.wPct(3.5)),
        border: highlighted
            ? Border.all(color: AppColors.aquaTeal, width: context.wPct(0.3))
            : null,
        boxShadow: highlighted
            ? [
                BoxShadow(
                  color: AppColors.aquaTealShadow,
                  blurRadius: context.wPct(5),
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                ),
              ]
            : [],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(context.wPct(2)),
            child: GestureDetector(
              onTap: () => {
                Get.toNamed(Routes.employer, arguments: {'id': job.company.id}),
              },
              child: AppNetworkImage(
                url: job.company.logo ?? '',
                width: context.wPct(12),
                height: context.wPct(12),
                fit: BoxFit.contain,
                borderRadius: BorderRadius.circular(context.wPct(2)),
              ),
            ),
          ),
          SizedBox(width: context.wPct(2)),
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
                SizedBox(height: context.hPct(1)),
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
          SizedBox(width: context.wPct(2)),
          Text(
            job.applicationStatus.displayName,
            style: TextStyle(
              color: highlighted
                  ? Colors.white
                  : _getStatusColor(job.applicationStatus),
              fontWeight: FontWeight.bold,
              fontSize: context.wPct(3.5),
            ),
          ),
        ],
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
    }
  }
}
