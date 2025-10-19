/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-16 10:52 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:para_job/packages/api_client/src/models/responses/job.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class FlexibleJobsMiniList extends StatelessWidget {
  final List<Job> jobs;
  final VoidCallback? onSeeAll;

  const FlexibleJobsMiniList({super.key, required this.jobs, this.onSeeAll});

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
            Text(
              "Flexible Jobs",
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
        // Horizontal List of Job Cards
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: jobs.length,
          separatorBuilder: (_, __) => context.hBox(3),
          itemBuilder: (context, index) {
            return Text('text');
          },
        ),
      ],
    );
  }
}
