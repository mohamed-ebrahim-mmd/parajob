import 'package:flutter/material.dart';
import 'package:para_job/features/job_details/complaint/widgets/job_complaint_bottom_sheet.dart';
import 'package:para_job/packages/api_client/src/models/responses/job_data.dart'
    show JobData;
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class JobContent extends StatelessWidget {
  const JobContent({super.key, required this.jobDetails, this.onCompanyTap});

  final JobData jobDetails;
  final VoidCallback? onCompanyTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
            const Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            IconButton(
              onPressed: () {
                showJobComplaintBottomSheet(
                  jobName: jobDetails.title,
                  jobId: jobDetails.id,
                  isSubmitComplaint: jobDetails.isSubmitComplaint ?? false,
                );
              },
              icon: const Icon(Icons.more_vert, color: AppColors.pureWhite),
            ),
          ],
        ),
        context.hBox(2),
        Text(
          jobDetails.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.pureWhite,
            fontSize: context.wPct(8),
            fontWeight: FontWeight.w600,
          ),
        ),
        context.hBox(2),
        GestureDetector(
          onTap: onCompanyTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: context.wPct(5),
                backgroundColor: AppColors.softWhite70,
                backgroundImage: NetworkImage(jobDetails.company.logo ?? ""),
              ),

              context.wBox(2),
              Text(
                jobDetails.company.name ?? "",
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(4),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
