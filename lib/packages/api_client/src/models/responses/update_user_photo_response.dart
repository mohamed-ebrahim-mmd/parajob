import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class UpdateUserPhotoResponse {
  final bool isSuccess;
  final ResponseDetails details;

  UpdateUserPhotoResponse({required this.isSuccess, required this.details});

  factory UpdateUserPhotoResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserPhotoResponse(
      isSuccess: json['is_success'] ?? false,

      details: ResponseDetails.fromJson(json["details"]),
    );
  }
}
