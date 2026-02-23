import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/my_notifications/my_notifications_controller.dart';
import 'package:para_job/features/my_notifications/widgets/message_spans.dart'
    show buildMessageSpans;
import 'package:para_job/features/my_notifications/widgets/notification_image.dart';
import 'package:para_job/packages/localization_manger/controller/localization_controller.dart'
    show LocalizationController;
import 'package:timeago/timeago.dart' as timeago;

import '../../../packages/api_client/src/models/responses/my_notification.dart';
import '../../../packages/themeing/media_query_values.dart';

class MyNotificationCard extends StatelessWidget {
  final localizationController = Get.find<LocalizationController>();
  final MyNotification myNotification;

  MyNotificationCard({super.key, required this.myNotification});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyNotificationsController>();
    final details = myNotification.details;
    final logoUrl = details.companyLogo;
    DateTime? createdAt;

    try {
      createdAt = DateTime.parse(myNotification.createdAt);
    } catch (_) {}

    final timeAgo = createdAt != null
        ? timeago.format(
            createdAt,
            locale: localizationController.isEnglish ? 'en_short' : 'ar_short',
          )
        : '';

    final messageSpans = buildMessageSpans(
      details,
      context.theme.textTheme.headlineLarge!,
    );

    return InkWell(
      onTap: () =>
          controller.handleNotificationTap(myNotification: myNotification),
      child: Container(
        padding: EdgeInsets.all(context.wPct(5)),
        color: myNotification.readAt == null
            ? Colors.white.withValues(alpha: .05)
            : null,
        child: Row(
          children: [
            NotificationImage(notificationDetails: details, logoUrl: logoUrl),
            context.wBox(4),
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
