class CheckInOutRequest {
  final int jobId;
  final String type;
  final String code;
  final DateTime scannedAt;

  CheckInOutRequest({
    required this.jobId,
    required this.type,
    required this.code,
    required this.scannedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
      'type': type,
      'code': code,
      'scanned_at': scannedAt.toIso8601String(),
    };
  }
}
