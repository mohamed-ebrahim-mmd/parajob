// Karim Toson || kareemtoson1@gmail.com || Wed Nov 12 2025 15:59:19

import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class NotificationTokenResponse {
  final Map<String, dynamic>? data;
  final bool isSuccess;
  final ResponseDetails details;

  NotificationTokenResponse({
    this.data,
    required this.isSuccess,
    required this.details,
  });

  factory NotificationTokenResponse.fromJson(Map<String, dynamic> json) {
    return NotificationTokenResponse(
      data: json['data'] != null
          ? Map<String, dynamic>.from(json['data'])
          : null,
      isSuccess: json['is_success'] ?? false,
      details: ResponseDetails.fromJson(json['details']),
    );
  }
}
