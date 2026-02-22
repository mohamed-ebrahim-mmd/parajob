//Mary Mark ||  mary.mark@moselaymd.com || Tue Feb 17 2026 17:57:01

import 'package:flutter/material.dart';
import 'package:para_job/features/my_notifications/widgets/notification_warning_icon.dart';
import 'package:para_job/packages/api_client/src/models/responses/my_notification_details.dart'
    show MyNotificationDetails;
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/app_network_image.dart';
import 'package:para_job/packages/ui_components/user_level_badge.dart';

class NotificationImage extends StatelessWidget {
  const NotificationImage({
    super.key,
    this.logoUrl,
    required this.notificationDetails,
  });

  final MyNotificationDetails notificationDetails;
  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    switch (notificationDetails.type) {
      case 'strike':
        return NotificationWarningIcon();

      case 'level_up':
        final level = int.tryParse(notificationDetails.level ?? '') ?? 1;
        return UserLevelBadge(level: level);

      default:
        return AppNetworkImage(
          url: logoUrl,
          width: context.wPct(12),
          height: context.wPct(12),
          borderRadius: BorderRadius.circular(context.wPct(2)),
        );
    }
  }
}
