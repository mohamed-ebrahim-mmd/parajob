import 'package:para_job/packages/api_client/src/models/models.dart';



class UserProfileData {
  final int? id;
  final String? name;
  final String? profilePicture;
  final int? jobsCount;
  final String? income;
  final int? companiesCount;
  final List<Job>? jobs;
  final List<Job>? savedJobs;
  final int? strikeCount;
  final List<dynamic>? strikeHistory;

  UserProfileData({
    this.id,
    this.name,
    this.profilePicture,
    this.jobsCount,
    this.income,
    this.companiesCount,
    this.jobs,
    this.savedJobs,
    this.strikeCount,
    this.strikeHistory,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      jobsCount: json['jobs_count'] ?? 0,
      income: json['income'] ?? '',
      companiesCount: int.tryParse(json['companies_count'].toString()) ?? 0,
      jobs: (json['jobs'] as List<dynamic>?)
              ?.map((e) => Job.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      savedJobs: (json['saved_jobs'] as List<dynamic>?)
              ?.map((e) => Job.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      strikeCount: json['strike_count'] ?? 0,
      strikeHistory: json['strike_history'] ?? [],
    );
  }


}
