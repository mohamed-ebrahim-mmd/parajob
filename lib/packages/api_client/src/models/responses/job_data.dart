
import 'package:para_job/packages/api_client/src/models/models.dart';


class JobData {
  final int id;
  final String title;
  final Company company;
  final String type;
  final String paymentOption;
  final String monthlySalary;
  final String location;
  final String? area;
  final String locationLink;
  final String description;
  final String category;
  final String requirements;
  final String startDate;
  final String endDate;
  final String? from;
  final String? to;
  final String? applicationDeadline;
  final List<String> skills;
  final bool isApplied;
  final String logo;
  final City city;
  final Department department;
  final int? applicationId;
  final bool? isSubmitComplaint;

  JobData({
    required this.id,
    required this.title,
    required this.company,
    required this.type,
    required this.paymentOption,
    required this.monthlySalary,
    required this.location,
    required this.area,
    required this.locationLink,
    required this.description,
    required this.category,
    required this.requirements,
    required this.startDate,
    required this.endDate,
    required this.from,
    required this.to,
    required this.applicationDeadline,
    required this.skills,
    required this.isApplied,
    required this.logo,
    required this.city,
    required this.department,
    required this.applicationId,
    required this.isSubmitComplaint,
  });

  factory JobData.fromJson(Map<String, dynamic> json) {
    return JobData(
      id: json['id'],
      title: json['title'] ?? '',
      company: Company.fromJson(json['company']),
      type: json['type'] ?? '',
      paymentOption: json['payment_option'] ?? '',
      monthlySalary: json['monthly_salary'] ?? '',
      location: json['location'] ?? '',
      area: json['area'],
      locationLink: json['location_link'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      requirements: json['requirements'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      from: json['from'],
      to: json['to'],
      applicationDeadline: json['application_deadline'],
      skills: (json['skills'] as List<dynamic>).map((e) => e.toString()).toList(),
      isApplied: json['is_applied'] ?? false,
      logo: json['logo'] ?? '',
      city: City.fromJson(json['city']),
      department: Department.fromJson(json['department']),
      applicationId: json['application_id'],
      isSubmitComplaint: json['is_submit_complaint'],
    );
  }
}



