import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';

class CheckInOutTimelineItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isActive;
  final bool isLast;

  const CheckInOutTimelineItem({
    super.key,
    required this.title,
    required this.value,
    this.isActive = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final circleColor = isActive ? Colors.greenAccent : AppColors.listTileBG;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "$title : ",
                      style: TextStyle(
                        color: AppColors.white60,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: value,
                      style: TextStyle(
                        color: isActive ? Colors.white : AppColors.white60,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              children: List.generate(
                6,
                    (index) => Container(
                  width: 2,
                  height: 4,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    color: AppColors.white15,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
