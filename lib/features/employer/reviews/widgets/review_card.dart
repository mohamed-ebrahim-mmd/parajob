import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:para_job/packages/api_client/src/models/responses/review.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';


class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final rate = review.rate ?? 0;
    final comment = review.review ?? "";
    final dateRaw = review.createdAt?.split(" ").first ?? "";
    String formattedDate = "";
    if (dateRaw.isNotEmpty) {
      final parsedDate = DateTime.tryParse(dateRaw);
      if (parsedDate != null) {
        formattedDate = DateFormat('dd.MM.yyyy').format(parsedDate);
      }
    }
    return Container(
      padding: EdgeInsets.all(context.wPct(3.5)),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(context.wPct(2.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  review.user?.name ?? "",
                  style: TextStyle(
                    fontSize: context.wPct(4),
                    fontWeight: FontWeight.w500,
                    color: AppColors.pureWhite,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: AppColors.almostWhite, size: context.wPct(2.5)),
                  SizedBox(width: context.wPct(1)),
                  Text(
                    rate.toString(),
                    style: TextStyle(
                      fontSize: context.wPct(2.5),
                      fontWeight: FontWeight.w500,
                      color: AppColors.pureWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: context.hPct(1)),
          Text(
            comment,
            style: TextStyle(
              fontSize: context.wPct(3.5),
              fontWeight: FontWeight.w400,
              color: AppColors.pureWhite,
            ),
          ),
          SizedBox(height: context.hPct(1)),
          Text(
            formattedDate,
            style: TextStyle(
              fontSize: context.wPct(2.5),
              fontWeight: FontWeight.w400,
              color: AppColors.softWhite70,
            ),
          ),
        ],
      ),
    );
  }
}
