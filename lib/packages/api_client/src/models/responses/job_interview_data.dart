//Mary Mark ||  mary.mark@moselaymd.com || Wed Dec 03 2025 15:11:18

import 'package:para_job/packages/api_client/src/enums/interview_status_enum.dart';
import 'package:para_job/packages/api_client/src/models/responses/company.dart';

class InterviewData {
  final int? id;
  final String? interviewDate;
  final String? from;
  final String? to;
  final String? mode;
  final String? location;
  final String? meetingLink;
  final JobInterview? job;
  final Company? company;
  final InterviewStatusEnum? userResponse;

  InterviewData({
    this.id,
    this.interviewDate,
    this.from,
    this.to,
    this.mode,
    this.location,
    this.meetingLink,
    this.job,
    this.company,
    this.userResponse,
  });

  factory InterviewData.fromJson(Map<String, dynamic> json) {
    return InterviewData(
      id: json['id'] as int?,
      interviewDate: json['interview_date'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      mode: json['mode'] as String?,
      location: json['location'] as String?,
      meetingLink: json['meeting_link'] as String?,
      job: json['job'] != null ? JobInterview.fromJson(json['job']) : null,
      company: json['company'] != null
          ? Company.fromJson(json['company'])
          : null,
      userResponse: json['user_response'] != null
          ? InterviewStatusEnum.values.firstWhere(
              (e) => e.value == json['user_response'],
              orElse: () => InterviewStatusEnum.notDeterminded,
            )
          : null,
    );
  }
}

class JobInterview {
  final String title;

  JobInterview({required this.title});

  factory JobInterview.fromJson(Map<String, dynamic> json) {
    return JobInterview(title: json['title']);
  }
}
