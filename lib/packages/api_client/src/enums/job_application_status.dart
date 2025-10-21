enum JobApplicationStatus {
  shortlisted,
  accepted,
  rejected,
  interviewScheduled,
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
      default:
        return JobApplicationStatus.shortlisted;
    }
  }

  String get displayName {
    switch (this) {
      case JobApplicationStatus.shortlisted:
        return 'Shortlisted';
      case JobApplicationStatus.accepted:
        return 'Accepted';
      case JobApplicationStatus.rejected:
        return 'Rejected';
      case JobApplicationStatus.interviewScheduled:
        return 'Interview Scheduled';
    }
  }
}
