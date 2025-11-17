import 'package:get/get.dart';

enum JobApplicationStatus {
  shortlisted,
  accepted,
  rejected,
  interviewScheduled,
  pending, // added
}

extension JobApplicationStatusExtension on JobApplicationStatus {
  String get value {
    switch (this) {
      case JobApplicationStatus.shortlisted:
        return 'shortlisted';
      case JobApplicationStatus.accepted:
        return 'accepted';
      case JobApplicationStatus.rejected:
        return 'rejected';
      case JobApplicationStatus.interviewScheduled:
        return 'interview_scheduled';
      case JobApplicationStatus.pending:
        return 'pending';
    }
  }

  static JobApplicationStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'shortlisted':
        return JobApplicationStatus.shortlisted;
      case 'accepted':
        return JobApplicationStatus.accepted;
      case 'rejected':
        return JobApplicationStatus.rejected;
      case 'interview_scheduled':
        return JobApplicationStatus.interviewScheduled;
      case 'pending':
        return JobApplicationStatus.pending;
      default:
        return JobApplicationStatus.shortlisted;
    }
  }

  String get displayName {
    switch (this) {
      case JobApplicationStatus.shortlisted:
        return 'job_status_shortlisted'.tr;
      case JobApplicationStatus.accepted:
        return 'job_status_accepted'.tr;
      case JobApplicationStatus.rejected:
        return 'job_status_rejected'.tr;
      case JobApplicationStatus.interviewScheduled:
        return 'job_status_interview_scheduled'.tr;
      case JobApplicationStatus.pending:
        return 'job_status_pending'.tr;
    }
  }
}
