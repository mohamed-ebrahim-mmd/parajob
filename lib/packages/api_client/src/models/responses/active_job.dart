
import 'package:para_job/packages/api_client/src/models/responses/job_combany.dart';

class ActiveJob {
  final int? id;
  final String? title;
  final String? description;
  final String? applicationDeadline;
  final List<String>? skills;
  final String? monthlySalary;
  final JobCompany? company;
  final bool? isApplied;
  final bool? isBookmark;

  ActiveJob({
    this.id,
    this.title,
    this.description,
    this.applicationDeadline,
    this.skills,
    this.monthlySalary,
    this.company,
    this.isApplied,
    this.isBookmark,
  });

  factory ActiveJob.fromJson(Map<String, dynamic> json) => ActiveJob(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        applicationDeadline: json["application_deadline"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"].map((x) => x)),
        monthlySalary: json["monthly_salary"],
        company: json["company"] == null
            ? null
            : JobCompany.fromJson(json["company"]),
        isApplied: json["is_applied"],
        isBookmark: json["is_bookmark"],
      );
}
