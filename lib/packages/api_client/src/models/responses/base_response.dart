import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class BaseResponse {
  final bool isSuccess;
  final ResponseDetails? details;

  BaseResponse({required this.isSuccess, this.details});

  factory BaseResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return BaseResponse(isSuccess: false);

    return BaseResponse(
      isSuccess: json['is_success'],
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }
}
