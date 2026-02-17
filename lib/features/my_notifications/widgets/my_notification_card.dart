import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/my_notifications/widgets/message_spans.dart'
    show buildMessageSpans;
import 'package:para_job/features/my_notifications/widgets/notification_image.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../packages/api_client/src/models/responses/my_notification.dart';
import '../../../packages/themeing/app_colors.dart';
import '../../../packages/themeing/media_query_values.dart';

class MyNotificationCard extends StatelessWidget {
  final MyNotification myNotification;

  const MyNotificationCard({super.key, required this.myNotification});

  @override
  Widget build(BuildContext context) {
    final details = myNotification.details;
    final logoUrl = details.companyLogo;
    DateTime? createdAt;

    final notificationType = myNotification.type;

    try {
      createdAt = DateTime.parse(myNotification.createdAt);
    } catch (_) {}

    final timeAgo = createdAt != null
        ? timeago.format(createdAt, locale: 'en_short')
        : '';

    final messageSpans = buildMessageSpans(
      details,
      context.theme.textTheme.headlineLarge!,
    );

    // Wrap the container with InkWell to make it tappable with visual feedback
    return InkWell(
      onTap: () {
        if (details.jobId?.isNotEmpty == true) {
          switch (notificationType) {
            case 'interview':
              Get.toNamed(
                '${Routes.mainNavigator}${Routes.interview}',
                arguments: {'id': details.modelId},
              );
              break;
            case 'strike':
              Get.toNamed(
                '${Routes.mainNavigator}${Routes.notificationStrikeScreen}',
              );
              break;
          }
        }
      },
      child: Container(
        padding: EdgeInsets.all(context.wPct(5)),
        color: myNotification.readAt == null ? AppColors.darkGrey : null,
        child: Row(
          children: [
            NotificationImage(
              notificationType: notificationType,
              logoUrl: logoUrl,
            ),
            context.wBox(4),

            //],
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: context.theme.textTheme.headlineMedium,
                  children: [
                    ...messageSpans,
                    TextSpan(
                      text: '  $timeAgo',
                      style: context.theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.grey.shade400,
                        fontSize: context.wPct(3.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
