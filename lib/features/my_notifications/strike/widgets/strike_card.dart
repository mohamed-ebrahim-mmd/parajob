//Mary Mark ||  mary.mark@moselaymd.com || Thu Nov 20 2025 15:18:45

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/my_notifications/strike/notification_strike_controller.dart';
import 'package:para_job/packages/api_client/src/models/responses/strike.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/app_network_image.dart';

class MyStrikeCard extends StatelessWidget {
  final Strike strike;
  final controller = Get.find<NotificationStrikeController>();
  final String langCode = Get.locale?.languageCode ?? 'en';

  MyStrikeCard({super.key, required this.strike});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.getFormattedDate(strike.createdAt, locale: langCode),
          style: TextStyle(
            fontSize: context.wPct(3.4),
            fontWeight: FontWeight.w500,
            color: AppColors.softWhite70,
          ),
        ),
        Container(
          padding: EdgeInsets.all(context.wPct(4)),

          margin: EdgeInsets.symmetric(vertical: context.hPct(1)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.wPct(3.5)),
            border: Border.all(
              color: AppColors.lightSilverGray,
              width: context.wPct(0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(context.wPct(2)),
                child: AppNetworkImage(
                  url: strike.company?.logo ?? '',
                  width: context.wPct(12),
                  height: context.wPct(12),
                  fit: BoxFit.contain,
                  borderRadius: BorderRadius.circular(context.wPct(2)),
                ),
              ),
              context.wBox(2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strike.job.title,
                      style: TextStyle(
                        fontSize: context.wPct(4),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    context.hBox(1),

                    Text(
                      strike.company?.name ?? "",
                      style: TextStyle(
                        fontSize: context.wPct(3.2),
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              context.wBox(2),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    strike.job.salary,
                    style: TextStyle(
                      fontSize: context.wPct(4),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  context.hBox(1),

                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: context.wPct(3.5),
                      ),
                      context.wBox(0.5),
                      Text(
                        controller.getFormattedDate(
                          strike.job.startDate,
                          locale: langCode,
                        ),
                        style: TextStyle(
                          fontSize: context.wPct(3.2),
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        Row(
          children: [
            context.wBox(4),
            Icon(
              Icons.warning_amber_rounded,
              color: AppColors.rejected,
              size: context.wPct(4),
            ),
            context.wBox(1),

            Text(
              strike.reason,
              style: TextStyle(
                fontSize: context.wPct(2.5),
                fontWeight: FontWeight.w400,
                color: AppColors.rejected,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
