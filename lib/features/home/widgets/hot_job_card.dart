/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-16 2:50 PM
 ==================================================================
*/

import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../../../packages/api_client/src/models/responses/job.dart' show Job;

class HotJobCard extends StatelessWidget {
  final Job job;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  late final bool isBookmarked = job.isBookmark ?? false;

  HotJobCard({super.key, required this.job, this.onTap, this.onBookmarkTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                    job.company?.logo ?? "",
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
                        job.title ?? "",
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: context.wPct(4),
                        ),
                      ),
                      Text(
                        job.company?.name ?? "",
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
                itemCount: job.skills!.length,
                separatorBuilder: (_, __) => context.wBox(2),
                itemBuilder: (context, index) {
                  final skill = job.skills?[index];
                  return Chip(
                    label: Text(
                      skill!,
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
              job.description ?? "",
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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // handle apply action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pureWhite,
                      foregroundColor: const Color(0xFF122A2B),
                      minimumSize: Size(double.infinity, context.hPct(7)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.wPct(4)),
                      ),
                    ),
                    child: const Text(
                      "Apply now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                context.wBox(3),
                // Icon container
                GestureDetector(
                  onTap: onBookmarkTap,
                  child: Container(
                    height: context.hPct(7),
                    padding: EdgeInsets.all(context.hPct(1.4)),
                    decoration: BoxDecoration(
                      color: isBookmarked
                          ? AppColors.aquaTeal8
                          : Colors.transparent, // transparent background
                      borderRadius: BorderRadius.circular(context.wPct(4)),
                      border: Border.all(
                        color: isBookmarked
                            ? AppColors.aquaTeal8
                            : AppColors.softWhite80, // your border color
                        width: 1.5, // adjust thickness
                      ),
                    ),
                    child: Icon(
                      Icons.bookmark_border,
                      color: isBookmarked
                          ? AppColors.aquaTeal
                          : AppColors.softWhite80,
                      size: context.hPct(4),
                    ),
                  ),
                ),

                // Expanded button
              ],
            ),
          ],
        ),
      ),
    );
  }
}
