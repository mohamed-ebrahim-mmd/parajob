/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-22 10:21 AM
 ==================================================================
*/

import 'package:para_job/packages/api_client/src/models/responses/job.dart';

class JobListResponse {
  final List<Job>? data;
  final bool? isSuccess;

  JobListResponse({this.data, this.isSuccess});

  factory JobListResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return JobListResponse();

    return JobListResponse(
      data: json['data'] != null
          ? List<Job>.from(json['data'].map((x) => Job.fromJson(x)))
          : null,
      isSuccess: json['is_success'],
    );
  }
}
