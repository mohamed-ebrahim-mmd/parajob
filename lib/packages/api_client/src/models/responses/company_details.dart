
import 'package:para_job/packages/api_client/api_client.dart';

class CompanyDetailsResponse {
  final CompanyData data;
  final bool isSuccess;
  final ResponseDetails details;

  CompanyDetailsResponse({
    required this.data,
    required this.isSuccess,
    required this.details,
  });

  factory CompanyDetailsResponse.fromJson(Map<String, dynamic> json) =>
      CompanyDetailsResponse(
        details: ResponseDetails.fromJson(json["details"]),
         data: CompanyData.fromJson(json['data']),
      isSuccess: json['is_success'] ?? false,
      );
}

class CompanyData {
  final int? id;
  final String? name;
  final String? logo;
  final String? industry;
  final int? jobPostsCount;
  final int? employeesCount;
  final int? reviewsCount;
  final List<LatestReview>? latestReviews;
  final double? averageRating;
  final double? positiveReviewsPercentage;
  final List<Job>? activeJobs;
  final String? accountStatus;
  final String? rejectionReason;
  final int? isBlocked;

  CompanyData({
    this.id,
    this.name,
    this.logo,
    this.industry,
    this.jobPostsCount,
    this.employeesCount,
    this.reviewsCount,
    this.latestReviews,
    this.averageRating,
    this.positiveReviewsPercentage,
    this.activeJobs,
    this.accountStatus,
    this.rejectionReason,
    this.isBlocked,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        industry: json["industry"],
        jobPostsCount: json["job_posts_count"],
        employeesCount: json["employees_count"],
        reviewsCount: json["reviews_count"],
        latestReviews: json["latest_reviews"] == null
            ? []
            : List<LatestReview>.from(
                json["latest_reviews"].map((x) => LatestReview.fromJson(x))),
        averageRating: (json["average_rating"] as num?)?.toDouble(),
        positiveReviewsPercentage:
            (json["positive_reviews_percentage"] as num?)?.toDouble(),
        activeJobs: json["active_jobs"] == null
            ? []
            : List<Job>.from(
                json["active_jobs"].map((x) => Job.fromJson(x))),
        accountStatus: json["account_status"],
        rejectionReason: json["rejection_reason"],
        isBlocked: json["is_blocked"],
      );
}


