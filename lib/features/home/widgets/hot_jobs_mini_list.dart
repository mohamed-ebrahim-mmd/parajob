/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-16 10:52 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/features/home/widgets/hot_jobs_cards.dart';
import 'package:para_job/packages/api_client/src/models/responses/job.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class HotJobsMiniList extends StatelessWidget {
  final List<Job> jobs;
  final VoidCallback? onSeeAll;

  const HotJobsMiniList({super.key, required this.jobs, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.red,
      height: context.hPct(52.5), // adjust to fit your design
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.red,
                    size: context.hPct(4),
                  ),
                  context.wBox(2),
                  Text(
                    "Hot Jobs",
                    style: TextStyle(
                      fontSize: context.wPct(4.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
          // Horizontal List of Job Cards
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: jobs.length,
              separatorBuilder: (_, __) => context.wBox(3),
              itemBuilder: (context, index) {
                return 
                //Text("data");
               HotJobCard(job: jobs[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
