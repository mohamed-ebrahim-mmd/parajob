/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-15 3:26 PM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/responses/job.dart';

class HomeResponse {
  final List<JobCategories> data;
  final bool isSuccess;

  HomeResponse({required this.data, required this.isSuccess});

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      data: (json['data'] as List)
          .map((item) => JobCategories.fromJson(item))
          .toList(),
      isSuccess: json['is_success'],
    );
  }
}

class JobCategories {
  final List<Job> flexibleJobs;
  final List<Job> nonFlexibleJobs;
  final List<Job> hotJobs;

  JobCategories({
    required this.flexibleJobs,
    required this.nonFlexibleJobs,
    required this.hotJobs,
  });

  factory JobCategories.fromJson(Map<String, dynamic> json) {
    return JobCategories(
      flexibleJobs: (json['flexible_jobs'] as List)
          .map((item) => Job.fromJson(item))
          .toList(),
      nonFlexibleJobs: (json['non_flexible_jobs'] as List)
          .map((item) => Job.fromJson(item))
          .toList(),
      hotJobs: (json['hot_jobs'] as List)
          .map((item) => Job.fromJson(item))
          .toList(),
    );
  }
}
