import 'package:para_job/packages/api_client/src/models/models.dart';

class UploadFilesResponse {
  final Map<String, dynamic> data;
  final bool isSuccess;
  final ResponseDetails details;

  UploadFilesResponse({
    required this.data,
    required this.isSuccess,
    required this.details,
  });

  factory UploadFilesResponse.fromJson(Map<String, dynamic> json) {
    return UploadFilesResponse(
      data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : {},
      isSuccess: json['is_success'] ?? false,
      details: ResponseDetails.fromJson(json['details']),
    );
  }
}
