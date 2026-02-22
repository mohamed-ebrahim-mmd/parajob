/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-29 5:06 PM
 ==================================================================
*/
import 'package:flutter/material.dart' show TextSpan, TextStyle;
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/src/models/responses/my_notification_details.dart';

List<TextSpan> buildMessageSpans(
  MyNotificationDetails d,
  TextStyle highlightTextStyle,
) {
  switch (d.type) {
    case 'interview':
      return [
        TextSpan(text: 'notification_interview_prefix'.tr),
        TextSpan(text: d.jobTitle ?? '', style: highlightTextStyle),
        TextSpan(text: 'notification_at'.tr),
        TextSpan(text: d.companyName ?? '', style: highlightTextStyle),
        TextSpan(
          text: switch (d.status) {
            'cancel' => 'notification_interview_cancelled'.tr,
            'reschedule' => 'notification_interview_rescheduled'.tr,
            _ => 'notification_interview_scheduled'.tr,
          },
        ),
      ];

    case 'employee_rating':
      if (d.rate != null) {
        return [
          TextSpan(text: d.companyName ?? '', style: highlightTextStyle),
          TextSpan(text: 'notification_rated_you'.tr),
          TextSpan(text: '${d.rate}', style: highlightTextStyle),
          TextSpan(text: 'notification_stars'.tr),
        ];
      }
      return [
        TextSpan(text: 'notification_please_rate'.tr),
        TextSpan(text: d.jobTitle ?? '', style: highlightTextStyle),
        const TextSpan(text: '.'),
      ];

    case 'job':
      return [
        TextSpan(text: 'notification_new_job'.tr),
        TextSpan(text: d.jobTitle ?? '', style: highlightTextStyle),
        TextSpan(text: 'notification_at'.tr),
        TextSpan(text: d.companyName ?? '', style: highlightTextStyle),
        const TextSpan(text: '.'),
      ];

    case 'strike':
      return [TextSpan(text: 'notification_strike_warning'.tr)];

    default:
      return [TextSpan(text: 'notification_new_generic'.tr)];
  }
}
