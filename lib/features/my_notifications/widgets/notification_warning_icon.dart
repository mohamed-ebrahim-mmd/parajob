//Mary Mark ||  mary.mark@moselaymd.com || Tue Feb 17 2026 17:23:39

import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class NotificationWarningIcon extends StatelessWidget {
  const NotificationWarningIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.wPct(12),
      height: context.wPct(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.wPct(2)),
      ),
      child: Center(
        child: Icon(
          Icons.warning_amber_rounded,
          color: AppColors.rejected,
          size: context.wPct(9.5),
        ),
      ),
    );
  }
}
