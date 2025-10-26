import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/ui_components/job_card.dart';
import 'package:para_job/packages/api_client/src/models/models.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class ActiveJobList extends StatelessWidget {
  final List<Job> jobs;
  final VoidCallback? onSeeAll;

  const ActiveJobList({super.key, required this.jobs, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: jobs.length,
      separatorBuilder: (_, __) => context.wBox(3),
      itemBuilder: (context, index) {
        var job = jobs[index];
        return SizedBox(
          width: context.wPct(90),
          child: JobCard(
            job: job,
            onTap: () {
              Get.toNamed(Routes.jobDetails, arguments: job.id);
            },
          ),
        );
      },
    );

    // SizedBox(
    //   //color: Colors.red,
    // //  height: context.hPct(30.5), // adjust to fit your design
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       // Header Row
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(
    //                 "Active Jobs",
    //                 style: TextStyle(
    //                   fontSize: context.wPct(4.5),
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //           GestureDetector(
    //             onTap: onSeeAll,
    //             child: Text(
    //               "See all",
    //               style: TextStyle(
    //                 color: AppColors.softWhite70,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       context.hBox(2),
    //       // Horizontal List of Job Cards

    //     ],
    //   ),
    // );
  }
}
