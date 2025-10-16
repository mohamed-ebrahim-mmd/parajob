/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-16 10:52 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
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
      height: context.hPct(55), // adjust to fit your design
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
                return HotJobCard(job: jobs[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HotJobCard extends StatelessWidget {
  final Job job;

  const HotJobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.wPct(65),
      decoration: BoxDecoration(
        color: const Color(0xFF122A2B),
        borderRadius: BorderRadius.circular(context.wPct(4)),
      ),
      padding: EdgeInsets.all(context.wPct(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company + Logo
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  context.wPct(2),
                ), // adjust corner roundness
                child: Image.network(
                  job.company.logo ?? '',
                  width: context.wPct(
                    12,
                  ), // same visual size as before (≈ diameter)
                  height: context.wPct(12),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: context.wPct(12),
                    height: context.wPct(12),
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              context.wBox(4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.wPct(4),
                      ),
                    ),
                    Text(
                      job.company.name,
                      maxLines: 1,

                      style: TextStyle(
                        color: AppColors.softWhite70,
                        fontSize: context.wPct(3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          context.hBox(1.5),
          // Skills tags
          SizedBox(
            height: context.hPct(5), // small fixed height for chips
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: job.skills.length,
              separatorBuilder: (_, __) => context.wBox(2),
              itemBuilder: (context, index) {
                final skill = job.skills[index];
                return Chip(
                  label: Text(
                    skill,
                    style: TextStyle(color: const Color(0xFF122A2B)),
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFF80E5DB)),
                    borderRadius: BorderRadius.circular(
                      context.w,
                    ), // makes it nicely rounded
                  ),
                  backgroundColor: const Color(0xFF80E5DB),

                  padding: EdgeInsets.all(context.wPct(1)),
                );
              },
            ),
          ),
          context.hBox(1.5),
          // Description
          Text(
            "job.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.descriptionjob.description",
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.softWhite70,
              fontSize: context.wPct(3),
            ),
          ),
          Spacer(),
          context.hBox(1), // Salary + Deadline

          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${job.monthlySalary} EGP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: context.wPct(5),
                  ),
                ),
                TextSpan(
                  text: "/mo",
                  style: TextStyle(
                    color: AppColors.softWhite70,
                    fontSize: context.wPct(3),
                  ),
                ),
              ],
            ),
          ),
          context.hBox(1), // Salary + Deadline
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.date_range_rounded,
                    size: context.wPct(3),
                    color: Colors.grey,
                  ),
                ),
                WidgetSpan(child: context.wBox(1)),
                // space between icon and text
                TextSpan(
                  text: job.applicationDeadline ?? "-",
                  style: TextStyle(
                    color: AppColors.softWhite70,
                    fontSize: context.wPct(3),
                  ),
                ),
              ],
            ),
          ),
          context.hBox(1.5),
          // Apply Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pureWhite,
              foregroundColor: const Color(0xFF122A2B),
              minimumSize: Size(double.infinity, context.hPct(7)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.wPct(4)),
              ),
            ),
            child: const Text("Apply now"),
          ),
        ],
      ),
    );
  }
}
