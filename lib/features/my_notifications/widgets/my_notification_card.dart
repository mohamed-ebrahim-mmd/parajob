import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/my_notifications/widgets/message_spans.dart'
    show buildMessageSpans;
import 'package:timeago/timeago.dart' as timeago;

import '../../../packages/api_client/src/models/responses/my_notification.dart';
import '../../../packages/themeing/app_colors.dart';
import '../../../packages/themeing/media_query_values.dart';
import '../../../packages/ui_components/app_network_image.dart';

class MyNotificationCard extends StatelessWidget {
  final MyNotification myNotification;

  const MyNotificationCard({super.key, required this.myNotification});

  @override
  Widget build(BuildContext context) {
    final d = myNotification.details;
    final logoUrl = d.companyLogo;
    DateTime? createdAt;

    try {
      createdAt = DateTime.parse(myNotification.createdAt);
    } catch (_) {}

    final timeAgo = createdAt != null
        ? timeago.format(createdAt, locale: 'en_short')
        : '';

    final messageSpans = buildMessageSpans(
      d,
      context.theme.textTheme.headlineLarge!,
    );

    return Container(
      padding: EdgeInsets.all(context.wPct(5)),
      color: myNotification.readAt == null ? AppColors.darkGrey : null,
      child: Row(
        children: [
          //    if (logoUrl != null && logoUrl.isNotEmpty) ...[
          AppNetworkImage(
            url: logoUrl,
            width: context.wPct(12),
            height: context.wPct(12),
            borderRadius: BorderRadius.circular(context.wPct(2)),
          ),
          SizedBox(width: context.wPct(4)),
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
    );
  }
}
