class MyNotificationDetails {
  final String? type;
  final String? status;
  final String? jobId;
  final String? modelId;
  final String? jobTitle;
  final String? companyId;
  final String? companyLogo;
  final String? companyName;
  final String? rate;

  MyNotificationDetails({
    this.type,
    this.status,
    this.jobId,
    this.modelId,
    this.jobTitle,
    this.companyId,
    this.companyLogo,
    this.companyName,
    this.rate,
  });

  factory MyNotificationDetails.fromJson(Map<String, dynamic> json) {
    return MyNotificationDetails(
      type: json['type'],
      status: json['status'],
      jobId: json['job_id'],
      modelId: json['model_id'],
      jobTitle: json['job_title'],
      companyId: json['company_id'],
      companyLogo: json['company_logo'],
      companyName: json['company_name'],
      rate: json['rate'],
    );
  }
}
