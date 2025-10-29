/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-29 5:06 PM
 ==================================================================
*/
import 'package:flutter/material.dart' show TextSpan, TextStyle;
import 'package:para_job/packages/api_client/src/models/responses/my_notification_details.dart';

List<TextSpan> buildMessageSpans(
  MyNotificationDetails d,
  TextStyle highlightTextStyle,
) {
  switch (d.type) {
    case 'interview':
      return [
        const TextSpan(text: 'Your interview for '),
        TextSpan(text: d.jobTitle ?? '', style: highlightTextStyle),
        const TextSpan(text: ' at '),
        TextSpan(text: d.companyName ?? '', style: highlightTextStyle),
        TextSpan(
          text: switch (d.status) {
            'cancel' => ' was cancelled.',
            'reschedule' => ' has been rescheduled.',
            _ => ' has been scheduled.',
          },
        ),
      ];

    case 'employee_rating':
      if (d.rate != null) {
        return [
          TextSpan(text: d.companyName ?? '', style: highlightTextStyle),
          const TextSpan(text: ' rated you '),
          TextSpan(text: '${d.rate}', style: highlightTextStyle),
          const TextSpan(text: ' stars.'),
        ];
      }
      return [
        const TextSpan(text: 'Please rate your experience for '),
        TextSpan(text: d.jobTitle ?? '', style: highlightTextStyle),
        const TextSpan(text: '.'),
      ];

    case 'job':
      return [
        const TextSpan(text: 'New job available: '),
        TextSpan(text: d.jobTitle ?? '', style: highlightTextStyle),
        const TextSpan(text: ' at '),
        TextSpan(text: d.companyName ?? '', style: highlightTextStyle),
        const TextSpan(text: '.'),
      ];

    case 'strike':
      return [const TextSpan(text: 'Warning! You have received a strike.')];

    default:
      return [const TextSpan(text: 'You have a new notification.')];
  }
}
