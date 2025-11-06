import 'package:para_job/packages/api_client/api_client.dart';

class BookmarkedJobs {
  final List<Job>? data;
  final Meta meta;
  final bool isSuccess;
  final ResponseDetails? details;

  BookmarkedJobs({
    required this.data,
    required this.meta,
    required this.isSuccess,
    required this.details,
  });

  factory BookmarkedJobs.fromJson(Map<String, dynamic> json) {
    return BookmarkedJobs(
      data: json['data'] != null
          ? List<Job>.from(json['data'].map((x) => Job.fromJson(x)))
          : null,
      meta: Meta.fromJson(json['meta']),
      isSuccess: json['is_success'] ?? false,
      details: ResponseDetails.fromJson(json['details']),
    );
  }
}

class Meta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  Meta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      perPage: json['per_page'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
    };
  }
}
