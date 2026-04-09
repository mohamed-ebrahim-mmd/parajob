import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/employer/reviews/widgets/review_card.dart';
import 'package:para_job/packages/api_client/src/models/responses/company.dart'
    show Company;
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class LatestReviewsList extends StatelessWidget {
  final Company company;

  const LatestReviewsList({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    if (company.latestReviews != null && company.latestReviews!.isNotEmpty) {
      return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: company.latestReviews!.length,
        separatorBuilder: (_, __) => context.hBox(1),
        itemBuilder: (context, index) {
          final review = company.latestReviews![index];
          return ReviewCard(review: review);
        },
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wPct(2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.work_outline,
              color: AppColors.white40,
              size: context.hPct(2.5),
            ),
            context.wBox(2),
            Text(
              "no_recent_reviews".tr,
              style: TextStyle(
                fontSize: context.wPct(4),
                color: AppColors.white40,
              ),
            ),
          ],
        ),
      );
    }
  }
}
