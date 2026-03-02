//Mary Mark ||  mary.mark@moselaymd.com || Mon Mar 02 2026 12:00:02

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EmptyJobs extends StatelessWidget {
  const EmptyJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: context.hPct(8),
            color: AppColors.pureWhite,
          ),

          context.hBox(2),

          Text(
            "no_jobs_found".tr,
            style: TextStyle(
              fontSize: context.wPct(6),
              color: AppColors.pureWhite,
            ),
          ),
        ],
      ),
    );
  }
}
