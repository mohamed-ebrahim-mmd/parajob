//Mary Mark ||  mary.mark@moselaymd.com || Thu Nov 20 2025 16:50:57

import 'package:para_job/packages/api_client/src/models/responses/strike.dart';

class NotificationWarningResponse {
  final List<Strike> data;
  final bool isSuccess;
  final bool isBlocked;

  NotificationWarningResponse({
    required this.data,
    required this.isSuccess,
    required this.isBlocked,
  });

  factory NotificationWarningResponse.fromJson(Map<String, dynamic> json) {
    return NotificationWarningResponse(
      data: (json["data"] as List).map((e) => Strike.fromJson(e)).toList(),
      isSuccess: json["is_success"] ?? false,
      isBlocked: json["is_blocked"] ?? false,
    );
  }
}
