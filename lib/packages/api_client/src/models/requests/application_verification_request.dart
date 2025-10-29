class ApplicationVerificationRequest {
  final String jobId;
  final String signature;

  ApplicationVerificationRequest({
    required this.jobId,
    required this.signature,
  });

  Map<String, dynamic> toJson() {
    return {'job_id': jobId, 'signature': signature};
  }
}
