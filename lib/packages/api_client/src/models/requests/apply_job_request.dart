class ApplyJobRequest {
  final int jobId;

  ApplyJobRequest({
    required this.jobId,
  });

  Map<String, dynamic> toJson() {
    return {'job_id': jobId};
  }
}

