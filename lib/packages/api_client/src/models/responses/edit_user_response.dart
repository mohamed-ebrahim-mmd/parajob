import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class EditUserResponse {
  final bool isSuccess;
  final ResponseDetails details;

  EditUserResponse({
    required this.isSuccess,
    required this.details,
  });

  factory EditUserResponse.fromJson(Map<String, dynamic> json) {
    return EditUserResponse(
      isSuccess: json['is_success'] ?? false,
      
    details:ResponseDetails.fromJson(json["details"]),
    );
  }

}