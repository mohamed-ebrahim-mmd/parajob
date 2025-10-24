import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

import 'meta.dart';
import 'review.dart';

class CompanyReviewsResponse {
  final List<Review>? data;
  final double? averageRate;
  final Meta? meta;
  final bool isSuccess;
  final ResponseDetails? details;

  CompanyReviewsResponse({
    this.data,
    this.averageRate,
    this.meta,
    required this.isSuccess,
    this.details,
  });

  factory CompanyReviewsResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CompanyReviewsResponse(isSuccess: false);

    var reviewsJson = json['data'] as List<dynamic>?;

    return CompanyReviewsResponse(
      data: reviewsJson?.map((e) => Review.fromJson(e)).toList(),
      averageRate: (json['average_rate'] != null)
          ? (json['average_rate'] as num).toDouble()
          : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      isSuccess: json['is_success'] ?? false,
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }
}
