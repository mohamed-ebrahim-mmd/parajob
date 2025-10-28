import 'package:para_job/packages/api_client/src/models/models.dart';

class UploadFilesResponse {
  final List<String>? data;
  final bool isSuccess;
  final ResponseDetails details;

  UploadFilesResponse({
    required this.data,
    required this.isSuccess,
    required this.details,
  });

  factory UploadFilesResponse.fromJson(Map<String, dynamic> json) {
    // Convert the weird {"0": "..."} map into a list of values
    List<String>? parseData(Map<String, dynamic>? rawData) {
      if (rawData == null) return null;
      return rawData.values.map((e) => e.toString()).toList();
    }

    return UploadFilesResponse(
      data: parseData(json['data']),
      isSuccess: json['is_success'] ?? false,
      details: ResponseDetails.fromJson(json['details']),
    );
  }
}