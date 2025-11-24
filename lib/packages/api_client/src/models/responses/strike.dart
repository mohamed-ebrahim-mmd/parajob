//Mary Mark ||  mary.mark@moselaymd.com || Thu Nov 20 2025 17:36:32


import 'package:para_job/packages/api_client/src/models/responses/company_data.dart';
import 'package:para_job/packages/api_client/src/models/responses/job_strike.dart';

class Strike {
  final int id;
  final String createdAt;
  final JobStrike job;
  final CompanyData? company;
  final String reason;

  Strike({
    required this.id,
    required this.createdAt,
    required this.job,
    required this.company,
    required this.reason,
  });

  factory Strike.fromJson(Map<String, dynamic> json) {
    return Strike(
      id: json["id"],
      createdAt: json["created_at"],
      job: JobStrike.fromJson(json["job"]),
      company: CompanyData.fromJson(json["company"]),
      reason: json["reason"] ?? "",
    );
  }
}


