/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-16 2:50 PM
 ==================================================================
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

import '../../../packages/api_client/src/models/responses/job.dart' show Job;

class HotJobCard extends StatelessWidget {
  final Job job;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;

  const HotJobCard({
    super.key,
    required this.job,
    this.onTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          left: context.wPct(1),
          bottom: context.hPct(1),
          top: context.hPct(1),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.wPct(.2),
          vertical: context.hPct(1),
        ),

        decoration: BoxDecoration(
          color: const Color(0xFF122A2B),
          borderRadius: BorderRadius.circular(context.wPct(4)),

          boxShadow: [
            BoxShadow(
              color: AppColors.aquaTeal, // shadow color
              spreadRadius: 1.5,
              blurRadius: 2,
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 👉 Company Row
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.wPct(4),
                vertical: context.hPct(1),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(context.wPct(2)),
                    child: Image.network(
                      job.company?.logo ?? "",

                      width: context.hPct(6),
                      height: context.hPct(6),
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        width: context.hPct(6),
                        height: context.hPct(6),
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
                            fontSize: context.hPct(2),
                          ),
                        ),
                        Text(
                          job.company?.name ?? "",
                          maxLines: 1,
                          style: TextStyle(
                            color: AppColors.softWhite70,
                            fontSize: context.hPct(1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 👉 Skills  Padding
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wPct(2.5)),
              child: SizedBox(
                height: context.hPct(4),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: job.skills!.length,
                  separatorBuilder: (_, __) => context.wBox(2),
                  itemBuilder: (context, index) {
                    final skill = job.skills?[index];
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.wPct(3),
                        vertical: context.hPct(0.5),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF80E5DB),

                        borderRadius: BorderRadius.circular(context.w),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        skill!,
                        style: TextStyle(
                          color: Color(0xFF122A2B),
                          fontSize: context.wPct(3.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // 👉 Description
            // 👉 Description (Fixed height always = 4 lines)
            Padding(
              padding: EdgeInsets.only(
                top: context.hPct(1),
                left: context.wPct(3),
                right: context.wPct(3),
              ),
              child: Text(
                job.description?.trim().isEmpty ?? true
                    ? " "
                    : job.description!,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(3.5),
                ),
              ),
            ),
            Spacer(),
            // 👉 Salary
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wPct(3)),
              child: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${job.monthlySalary ?? "-"} ${'egp'.tr}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.hPct(2.5),
                      ),
                    ),
                    TextSpan(
                      text: "per_month".tr,
                      style: TextStyle(
                        color: AppColors.softWhite70,
                        fontSize: context.hPct(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            context.hBox(1),

            // 👉 Deadline
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wPct(3)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.date_range_rounded,
                    size: context.wPct(4.5),
                    color: Colors.grey,
                  ),
                  context.wBox(1),
                  Expanded(
                    child: Text(
                      job.applicationDeadline ?? "-",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.softWhite70,
                        fontSize: context.wPct(3),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 👉 Buttons
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.wPct(2.5),
                vertical: context.hPct(0.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      final isApplied = job.isAppliedReactive.value;
                      return ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isApplied
                              ? AppColors.softWhite70.withValues(alpha: 0.2)
                              : AppColors.pureWhite,
                          foregroundColor: isApplied
                              ? AppColors.softWhite70
                              : const Color(0xFF122A2B),
                          minimumSize: Size(double.infinity, context.hPct(5)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              context.wPct(3),
                            ),
                          ),
                        ),
                        child: Text(
                          isApplied ? "applied".tr : "apply_now".tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }),
                  ),
                  context.wBox(2),
                  Obx(() {
                    final isBookmarked = job.isBookmarkedReactive.value;
                    return GestureDetector(
                      onTap: onBookmarkTap,
                      child: Container(
                        height: context.hPct(5),
                        padding: EdgeInsets.all(context.hPct(1)),
                        decoration: BoxDecoration(
                          color: isBookmarked
                              ? AppColors.aquaTeal8
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(context.wPct(3)),
                          border: Border.all(
                            color: isBookmarked
                                ? AppColors.aquaTeal8
                                : AppColors.softWhite80,
                            width: 1.2,
                          ),
                        ),
                        child: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked
                              ? AppColors.aquaTeal
                              : AppColors.softWhite80,
                          size: context.hPct(2.5),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
