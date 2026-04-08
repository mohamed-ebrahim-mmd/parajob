import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../api_client/src/models/responses/job.dart' show Job;

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final bool showBookmarkIcon;
  final double? width;

  late final bool isBookmarked = job.isBookmark ?? false;

  JobCard({
    super.key,
    required this.job,
    this.onTap,
    this.onBookmarkTap,
    this.showBookmarkIcon = true,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.circular(context.wPct(4)),
        ),
        padding: EdgeInsets.all(context.wPct(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //     // Company + Logo
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
                      child: Icon(
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
                // Icon container
                context.wBox(1),
                Visibility(
                  visible: showBookmarkIcon,
                  child: GestureDetector(
                    onTap: onBookmarkTap,
                    child: Container(
                      height: context.hPct(5),
                      padding: EdgeInsets.all(context.hPct(1)),
                      decoration: BoxDecoration(
                        color: isBookmarked
                            ? AppColors.aquaTeal8
                            : Colors.transparent, // transparent background
                        borderRadius: BorderRadius.circular(context.wPct(3)),
                        border: Border.all(
                          color: isBookmarked
                              ? AppColors.aquaTeal8
                              : AppColors.softWhite80, // your border color
                          width: 1.2, // adjust thickness
                        ),
                      ),
                      child: Icon(
                        Icons.bookmark_border,
                        color: isBookmarked
                            ? AppColors.aquaTeal
                            : AppColors.softWhite80,
                        size: context.hPct(2.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            context.hBox(1.5),
            //     // Skills tags
            SizedBox(
              height: context.hPct(2.5), // smaller fixed height for chips
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: job.skills!.length,
                separatorBuilder: (_, __) => context.wBox(1.5),
                itemBuilder: (context, index) {
                  final skill = job.skills?[index];
                  return Chip(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    labelPadding: EdgeInsets.symmetric(horizontal: 6),
                    label: Text(
                      skill!,
                      style: TextStyle(
                        color: const Color(0xff859097),
                        fontSize: 11,
                        height: 1,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.circular(context.w),
                    ),
                    backgroundColor: AppColors.lightGrey,
                  );
                },
              ),
            ),
            context.hBox(1),
            //price, date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${job.monthlySalary ?? "-"} ${'egp'.tr}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.wPct(5),
                          ),
                        ),
                        TextSpan(
                          text: "per_month".tr,
                          style: TextStyle(
                            color: AppColors.softWhite70,
                            fontSize: context.wPct(3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
