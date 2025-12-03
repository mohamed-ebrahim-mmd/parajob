//Mary Mark ||  mary.mark@moselaymd.com || Wed Dec 03 2025 14:15:17

import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class InterviewStatusResponse {
  final bool isSuccess;
  final ResponseDetails details;

  InterviewStatusResponse({required this.isSuccess, required this.details});

  factory InterviewStatusResponse.fromJson(Map<String, dynamic> json) {
    return InterviewStatusResponse(
      isSuccess: json['is_success'] ?? false,

      details: ResponseDetails.fromJson(json["details"]),
    );
  }
}