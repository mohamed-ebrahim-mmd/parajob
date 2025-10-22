import 'package:flutter/material.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.latestReview});
  final LatestReview latestReview;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: context.w,
      padding: EdgeInsets.symmetric(
        horizontal: context.wPct(3),
        vertical: context.hPct(3),
      ),
      decoration: BoxDecoration(
        color: Color(0x0DFFFFFF),
        borderRadius: BorderRadius.circular(context.wPct(2)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  latestReview.reviwer?.name?? "-",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: context.wPct(4),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
                Spacer(),
                Icon(Icons.star, color: AppColors.pureWhite),
                Text(
                  latestReview.rate.toString(),
                  style: TextStyle(color: AppColors.pureWhite),
                ),
              ],
            ),
            context.hBox(0.8),

            Text(
              latestReview.review ?? "-",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: context.wPct(5),
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
            context.hBox(0.8),
            Text(
              latestReview.createdAt ?? "-",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: context.wPct(3),
                color: AppColors.softWhite70,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ],
        ),
      ),
    );
  }
}
