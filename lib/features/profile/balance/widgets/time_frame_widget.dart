import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class TimeFrameWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeFrameWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wPct(3)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.wPct(4),
            vertical: context.hPct(1),
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.darkGray : Colors.transparent,
            borderRadius: BorderRadius.circular(context.wPct(5)),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.silverGray,
              fontSize: context.wPct(4),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
