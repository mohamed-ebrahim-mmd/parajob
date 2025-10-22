


import 'package:para_job/packages/api_client/api_client.dart';

class JobDetailsResponse {
  final JobData data;
  final bool isSuccess;
  final ResponseDetails details;

  JobDetailsResponse({
    required this.data,
    required this.isSuccess,
    required this.details,
  });

  factory JobDetailsResponse.fromJson(Map<String, dynamic> json) {
    return JobDetailsResponse(
      data: JobData.fromJson(json['data']),
      isSuccess: json['is_success'] ?? false,
      details: ResponseDetails.fromJson(json['details']),
    );
  }
}










