/*
   Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-15 3:26 PM
   ==================================================================
  */
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:para_job/packages/api_client/src/models/responses/company.dart';
import 'package:para_job/packages/api_client/src/models/responses/department.dart'
    show Department;

class Job {
  final int? id;
  final String? title;
  final String? description;
  final String? applicationDeadline;
  final List<String>? skills;
  final String? monthlySalary;
  final Company? company;
  final bool? isApplied;
  final bool? isBookmark; // backend value
  final RxBool isBookmarkedReactive; // reactive copy
  final String? category;
  final Department? department;
  final String? from;
  final String? to;
  final String? applicationStatus;
  final int? isSignedContract;
  final String? applicationDate;
  final int? jobApplicationVerification;

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
    this.category,
    this.department,
    this.from,
    this.to,
    this.applicationStatus,
    this.isSignedContract,
    this.applicationDate,
    this.jobApplicationVerification,
  }) : isBookmarkedReactive = RxBool(isBookmark ?? false);

  factory Job.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Job();

    return Job(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      applicationDeadline: json['application_deadline'],
      skills: json['skills'] != null ? List<String>.from(json['skills']) : null,
      monthlySalary: json['monthly_salary'],
      company: json['company'] != null
          ? Company.fromJson(json['company'])
          : null,
      isApplied: json['is_applied'],
      isBookmark: json['is_bookmark'],
      category: json['category'],
      department: json['department'] != null
          ? Department.fromJson(json['department'])
          : null,
      from: json['from'],
      to: json['to'],
      applicationStatus: json['application_status'],
      isSignedContract: json['is_signed_contract'],
      applicationDate: json['application_date'],
      jobApplicationVerification: json['job_application_verification'],
    );
  }

  Job copyWith({bool? isBookmark}) {
    return Job(
      id: id,
      title: title,
      description: description,
      applicationDeadline: applicationDeadline,
      skills: skills,
      monthlySalary: monthlySalary,
      company: company,
      isApplied: isApplied,
      isBookmark: isBookmark ?? this.isBookmark,
      category: category,
      department: department,
      from: from,
      to: to,
      applicationStatus: applicationStatus,
      isSignedContract: isSignedContract,
      applicationDate: applicationDate,
      jobApplicationVerification: jobApplicationVerification,
    );
  }
}
