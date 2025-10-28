import 'package:para_job/packages/api_client/src/enums/job_application_status.dart';

import 'company.dart';

class MyJob {
  final int id;
  final String title;
  final Company company;
  final JobApplicationStatus applicationStatus;
  final int isSignedContract;
  final String applicationDate;
  final bool jobApplicationVerification;

  MyJob({
    required this.id,
    required this.title,
    required this.company,
    required this.applicationStatus,
    required this.isSignedContract,
    required this.applicationDate,
    required this.jobApplicationVerification,
  });

  factory MyJob.fromJson(Map<String, dynamic> json) {
    return MyJob(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      company: Company.fromJson(json['company'] ?? {}),
      applicationStatus: JobApplicationStatusExtension.fromString(
        json['application_status'] ?? '',
      ),
      isSignedContract: json['is_signed_contract'] ?? 0,
      applicationDate: json['application_date'] ?? '',
      jobApplicationVerification:
          (json['job_application_verification'] ?? 0) == 1,
    );
  }
}
