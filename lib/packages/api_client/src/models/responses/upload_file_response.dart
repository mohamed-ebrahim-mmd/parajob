import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class UploadFileResponse {
  final List<String>? urls;
  final bool isSuccess;
  final ResponseDetails? details;

  UploadFileResponse({this.urls, required this.isSuccess, this.details});

  factory UploadFileResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return UploadFileResponse(isSuccess: false);

    final data = json['data'];
    List<String>? extractedUrls;

    if (data != null && data is Map) {
      // Extract all values (URLs) from the map
      extractedUrls = data.values.map((e) => e.toString()).toList();
    }

    return UploadFileResponse(
      urls: extractedUrls,
      isSuccess: json['is_success'] ?? false,
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }
}
