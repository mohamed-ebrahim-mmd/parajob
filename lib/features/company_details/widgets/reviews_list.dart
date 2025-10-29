import 'package:flutter/material.dart';
import 'package:para_job/features/company_details/widgets/review_item.dart';

import 'package:para_job/packages/api_client/src/models/models.dart';

import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class ReviewsList extends StatelessWidget {
  final List<LatestReview> reviews;
  final VoidCallback? onSeeAll;

  const ReviewsList({super.key, required this.reviews, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
    
      children: [
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Reviews",
              style: TextStyle(
                fontSize: context.wPct(4.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                "View all",
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
       
        // Vertical List of Job Cards
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reviews.length,
          separatorBuilder: (_, __) => context.hBox(2),
          itemBuilder: (context, index) {
            final review = reviews[index];
            return ReviewItem(
              latestReview: review,
              // onTap: () {
              //  Get.toNamed(Routes.jobDetails,
              //   arguments: job.id,);
              // },
            );
          },
        ),
      ],
    );
  }
}
