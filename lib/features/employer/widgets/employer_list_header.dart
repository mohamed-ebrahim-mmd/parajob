import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EmployerListHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;
  final String? viewAllText;
  final bool showViewAllButton;

  const EmployerListHeader({
    super.key,
    required this.title,
    this.onViewAll,
    this.viewAllText,
    this.showViewAllButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.tr, // make title itself localized
          style: TextStyle(
            fontSize: context.wPct(5),
            fontWeight: FontWeight.w600,
            color: AppColors.pureWhite,
          ),
        ),
        if (showViewAllButton)
          GestureDetector(
            onTap: onViewAll,
            child: Row(
              children: [
                Text(
                  (viewAllText ?? 'view_all'.tr),
                  style: TextStyle(
                    fontSize: context.wPct(3.5),
                    fontWeight: FontWeight.w500,
                    color: AppColors.pureWhite,
                  ),
                ),
                context.wBox(1),
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
