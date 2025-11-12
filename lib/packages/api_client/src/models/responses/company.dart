import 'package:para_job/packages/api_client/src/models/responses/review.dart';

import 'job.dart';

class Company {
  final int? id;
  final String? name;
  final String? logo;
  final String? industry;
  final int? jobPostsCount;
  final int? employeesCount;
  final int? reviewsCount;
  final List<Review>? latestReviews;
  final double? averageRating;
  final double? positiveReviewsPercentage;
  final List<Job>? activeJobs;
  final String? accountStatus;
  final String? rejectionReason;
  final int? isBlocked;
  final bool? isSubmitReview;
  final bool? isSubmitComplaint;

  Company({
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
    this.isSubmitReview,
    this.isSubmitComplaint,
  });

  factory Company.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Company();

    return Company(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      industry: json['industry'],
      jobPostsCount: json['job_posts_count'],
      employeesCount: json['employees_count'],
      reviewsCount: json['reviews_count'],
      latestReviews: (json['latest_reviews'] as List?)
          ?.map((e) => Review.fromJson(e))
          .toList(),
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      positiveReviewsPercentage: (json['positive_reviews_percentage'] as num?)
          ?.toDouble(),
      activeJobs: (json['active_jobs'] as List?)
          ?.map((e) => Job.fromJson(e))
          .toList(),
      accountStatus: json['account_status'],
      rejectionReason: json['rejection_reason'],
      isBlocked: json['is_blocked'],
      isSubmitReview: json['is_submit_review'],
      isSubmitComplaint: json['is_submit_complaint'],
    );
  }
}
