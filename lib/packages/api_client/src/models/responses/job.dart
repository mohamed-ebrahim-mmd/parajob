/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-15 3:26 PM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/responses/company.dart';

class Job {
  final int id;
  final String title;
  final String description;
  final String? applicationDeadline;
  final List<String> skills;
  final String monthlySalary;
  final Company company;
  final bool isApplied;
  final bool isBookmark;

  Job({
    required this.id,
    required this.title,
    required this.description,
    this.applicationDeadline,
    required this.skills,
    required this.monthlySalary,
    required this.company,
    required this.isApplied,
    required this.isBookmark,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      applicationDeadline: json['application_deadline'],
      skills: List<String>.from(json['skills'] ?? []),
      monthlySalary: json['monthly_salary'],
      company: Company.fromJson(json['company']),
      isApplied: json['is_applied'],
      isBookmark: json['is_bookmark'],
    );
  }
}
