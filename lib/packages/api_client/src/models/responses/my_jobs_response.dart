import 'meta.dart';
import 'my_job.dart';

class MyJobsResponse {
  final List<MyJob> data;
  final int acceptedCount;
  final Meta meta;
  final bool isSuccess;

  MyJobsResponse({
    required this.data,
    required this.acceptedCount,
    required this.meta,
    required this.isSuccess,
  });

  factory MyJobsResponse.fromJson(Map<String, dynamic> json) {
    return MyJobsResponse(
      data: (json['data'] as List)
          .map((item) => MyJob.fromJson(item))
          .toList(),
      acceptedCount: json['accepted_count'] ?? 0,
      meta: Meta.fromJson(json['meta'] ?? {}),
      isSuccess: json['is_success'] ?? false,
    );
  }
}