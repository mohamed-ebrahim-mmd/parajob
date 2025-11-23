//Mary Mark ||  mary.mark@moselaymd.com || Thu Nov 20 2025 19:35:50

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/my_notifications/strike/notification_strike_controller.dart';
import 'package:para_job/features/my_notifications/strike/widgets/strike_card.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class StrikesDetails extends StatelessWidget {
  StrikesDetails({super.key});
  final strikes = Get.find<NotificationStrikeController>().strikesData;
  final int totaAvailableStrikes = 3;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.hPct(8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: totaAvailableStrikes,
            itemBuilder: (context, index) {
              final color = index < strikes.length
                  ? AppColors.rejected
                  : AppColors.pureWhite;
              return Icon(
                Icons.warning_amber_rounded,
                color: color,
                size: context.wPct(10),
              );
            },
          ),
        ),

        Text(
          "violations_count".trParams({
            "current": min(strikes.length, totaAvailableStrikes).toString(),
            "total": totaAvailableStrikes.toString(),
          }),
          style: TextStyle(
            color: AppColors.pureWhite,
            fontSize: context.wPct(4),
            fontWeight: FontWeight.w400,
          ),
        ),
        context.hBox(2),

        ListView.separated(
          separatorBuilder: (context, index) => context.hBox(3),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: min(strikes.length, totaAvailableStrikes),
          itemBuilder: (context, index) {
            final strike = strikes[index];
            return MyStrikeCard(strike: strike);
          },
        ),
      ],
    );
  }
}
