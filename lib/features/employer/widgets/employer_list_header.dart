import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EmployerListHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;
  final String viewAllText;

  const EmployerListHeader({
    super.key,
    required this.title,
    required this.onViewAll,
    this.viewAllText = "View All",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: context.wPct(4.5),
            fontWeight: FontWeight.w600,
            color: AppColors.pureWhite,
          ),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: Row(
            children: [
              Text(
                viewAllText,
                style: TextStyle(
                  fontSize: context.wPct(3.5),
                  fontWeight: FontWeight.w500,
                  color: AppColors.pureWhite,
                ),
              ),
              SizedBox(width: context.wPct(1)),
              const Icon(
                Icons.double_arrow,
                size: 10,
                color: AppColors.pureWhite,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
