/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-15 3:26 PM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/responses/company.dart';

class Job {
  final int? id;
  final String? title;
  final String? description;
  final String? applicationDeadline;
  final List<String>? skills;
  final String? monthlySalary;
  final Company? company;
  final bool? isApplied;
  final bool? isBookmark;

  Job({
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

  factory Job.fromJson(Map<String, dynamic>? json) {
    return Job(
      id: json?['id'],
      title: json?['title'],
      description: json?['description'],
      applicationDeadline: json?['application_deadline'],
      skills: json?['skills'] != null
          ? List<String>.from(json!['skills'])
          : null,
      monthlySalary: json?['monthly_salary'],
      company: Company.fromJson(json?['company']),
      isApplied: json?['is_applied'],
      isBookmark: json?['is_bookmark'],
    );
  }
}
