//  @ Header: @Author: mary.mark@moselaymd.com |

import 'package:para_job/packages/api_client/api_client.dart';

class BookmarkedJobsResponse {
  final List<Job>? data;
  final Meta meta;
  final bool isSuccess;
  final ResponseDetails? details;

  BookmarkedJobsResponse({
    required this.data,
    required this.meta,
    required this.isSuccess,
    required this.details,
  });

  factory BookmarkedJobsResponse.fromJson(Map<String, dynamic> json) {
    return BookmarkedJobsResponse(
      data: json['data'] != null
          ? List<Job>.from(json['data'].map((x) => Job.fromJson(x)))
          : null,
      meta: Meta.fromJson(json['meta']),
      isSuccess: json['is_success'] ?? false,
      details: ResponseDetails.fromJson(json['details']),
    );
  }
}
