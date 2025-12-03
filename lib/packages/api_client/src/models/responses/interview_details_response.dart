//Mary Mark ||  mary.mark@moselaymd.com || Wed Dec 03 2025 14:21:34

import 'package:para_job/packages/api_client/src/models/responses/job_interview_data.dart';
import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class InterviewDetailsResponse {
  final InterviewData data;
  final bool isSuccess;
  final ResponseDetails details;

  InterviewDetailsResponse({
    required this.data,
    required this.isSuccess,
    required this.details,
  });

  factory InterviewDetailsResponse.fromJson(Map<String, dynamic> json) {
    return InterviewDetailsResponse(
      data: InterviewData.fromJson(json['data']),
      isSuccess: json['is_success'] ?? false,
      details: ResponseDetails.fromJson(json['details']),
    );
  }
}
