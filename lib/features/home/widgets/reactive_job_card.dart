/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 18/11/2025 11:01 AM
 ==================================================================
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/src/models/responses/job.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class ReactiveJobCard extends StatelessWidget {
  final Job job;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final bool showBookmarkIcon;
  final double? width;

  const ReactiveJobCard({
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
        padding: EdgeInsets.symmetric(
          horizontal: context.wPct(3),
          vertical: context.hPct(1.5),
        ),
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
                Obx(() {
                  final isBookmarked = job.isBookmarkedReactive.value;

                  return GestureDetector(
                    onTap: onBookmarkTap,
                    child: Container(
                      height: context.hPct(4.2),
                      padding: EdgeInsets.all(context.hPct(1)),
                      decoration: BoxDecoration(
                        color: isBookmarked
                            ? AppColors.aquaTeal8
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(context.wPct(3)),
                        border: Border.all(
                          color: isBookmarked
                              ? AppColors.aquaTeal8
                              : AppColors.gray8D,
                          width: 1.2,
                        ),
                      ),
                      child: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: isBookmarked
                            ? AppColors.aquaTeal
                            : AppColors.gray8D,
                        size: context.hPct(2),
                      ),
                    ),
                  );
                }),
              ],
            ),
            context.hBox(1),
            //     // Skills tags
            // Skills tags
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: job.skills!.map((skill) {
                  return Padding(
                    padding: EdgeInsetsGeometry.directional(
                      end: context.wPct(1.5),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.wPct(2.2), // horizontal spacing
                        vertical: context.hPct(0.3), // vertical padding
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        border: Border.all(color: AppColors.lightGrey),
                        borderRadius: BorderRadius.circular(context.w),
                      ),
                      child: Center(
                        child: Text(
                          skill,
                          style: TextStyle(
                            color: const Color(0xff859097),
                            fontSize: context.wPct(3),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
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
                          size: context.wPct(3.3),
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
