import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../packages/api_client/src/models/responses/my_notification.dart';
import '../../../packages/themeing/app_colors.dart';
import '../../../packages/themeing/media_query_values.dart';
import '../../../packages/ui_components/AppNetworkImage.dart';

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

    final timeAgo =
    createdAt != null ? timeago.format(createdAt, locale: 'en_short') : '';

    final textStyle = TextStyle(
        color: AppColors.white50,
        fontSize: context.wPct(3.8),
        fontWeight: FontWeight.w400
    );
    final highlightTextStyle = TextStyle(
        color: AppColors.pureWhite,
        fontSize: context.wPct(3.8),
        fontWeight: FontWeight.w600
    );

    List<TextSpan> messageSpans = [];

    switch (d.type) {
      case 'interview':
        messageSpans = [
          const TextSpan(text: 'Your interview for '),
          TextSpan(text: d.jobTitle ?? '', style: highlightTextStyle),
          const TextSpan(text: ' at '),
          TextSpan(text: d.companyName ?? '', style:highlightTextStyle),
          TextSpan(
            text: d.status == 'cancel'
                ? ' was cancelled.'
                : d.status == 'reschedule'
                ? ' has been rescheduled.'
                : ' has been scheduled.',
          ),
        ];
        break;

      case 'employee_rating':
        if (d.rate != null) {
          messageSpans = [
            TextSpan(text: d.companyName ?? '', style:highlightTextStyle),
            const TextSpan(text: ' rated you '),
            TextSpan(text: '${d.rate}', style: highlightTextStyle),
            const TextSpan(text: ' stars.'),
          ];
        } else {
          messageSpans = [
            const TextSpan(text: 'Please rate your experience for '),
            TextSpan(text: d.jobTitle ?? '', style:highlightTextStyle),
            const TextSpan(text: '.'),
          ];
        }
        break;

      case 'job':
        messageSpans = [
          const TextSpan(text: 'New job available: '),
          TextSpan(text: d.jobTitle ?? '', style: highlightTextStyle),
          const TextSpan(text: ' at '),
          TextSpan(text: d.companyName ?? '', style: highlightTextStyle),
          const TextSpan(text: '.'),
        ];
        break;

      case 'strike':
        messageSpans = [
          const TextSpan(text: 'Warning! You have received a strike.'),
        ];
        break;

      default:
        messageSpans = [
          const TextSpan(text: 'You have a new notification.'),
        ];
    }

    return Container(
      padding: EdgeInsets.all(context.wPct(5)),
      color: myNotification.readAt == null? AppColors.darkGrey: null,
      child: Row(
        children: [
          if (logoUrl != null && logoUrl.isNotEmpty) ...[
            AppNetworkImage(
              url: logoUrl,
              width: context.wPct(12),
              height: context.wPct(12),
              borderRadius: BorderRadius.circular(context.wPct(2)),
            ),
            SizedBox(width: context.wPct(4)),
          ],
          Expanded(
            child: RichText(
              text: TextSpan(
                style: textStyle,
                children: [
                  ...messageSpans,
                  TextSpan(
                    text: '  $timeAgo',
                    style: textStyle.copyWith(color: Colors.grey.shade400, fontSize: context.wPct(3.2)),
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
