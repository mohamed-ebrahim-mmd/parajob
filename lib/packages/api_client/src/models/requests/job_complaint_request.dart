class JobComplaintRequest {
  final int jobId;
  final String details;

  JobComplaintRequest({required this.jobId, required this.details});

  Map<String, dynamic> toJson() {
    return {'job_id': jobId, 'details': details};
  }
}
