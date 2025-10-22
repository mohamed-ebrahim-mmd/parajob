/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-16 10:52 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/widgets/job_card.dart';
import 'package:para_job/packages/api_client/src/models/responses/job.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class JobsMiniList extends StatelessWidget {
  final List<Job> jobs;
  final VoidCallback? onSeeAll;
  final String title;

  const JobsMiniList({super.key, required this.jobs, this.onSeeAll, required this.title});

  @override
  Widget build(BuildContext context) {
    return
    
    
     Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: context.wPct(4.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                "See all",
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
            final job =  jobs[index];
            return JobCard(job: job,
            onTap: () {
             Get.toNamed(Routes.jobDetails,
              arguments: job.id,);

            },
            
            );
          },
        ),
      ],
    );
 
 
 
  }
}
