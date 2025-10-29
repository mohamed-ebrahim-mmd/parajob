import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class UploadFileResponse {
  final String? url;
  final bool isSuccess;
  final ResponseDetails? details;

  UploadFileResponse({
    this.url,
    required this.isSuccess,
    this.details,
  });

  factory UploadFileResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return UploadFileResponse(isSuccess: false);
    final data = json['data'];
    String? extractedUrl;

    if (data != null) {
      if (data is Map && data.containsKey('0')) {
        extractedUrl = data['0'] as String?;
      }
    }

    return UploadFileResponse(
      url: extractedUrl,
      isSuccess: json['is_success'] ?? false,
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }
}
