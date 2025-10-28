import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class DeleteAccountResponse {
  final bool isSuccess;
  final ResponseDetails details;

  DeleteAccountResponse({
    required this.isSuccess,
    required this.details,
  });

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) {
    return DeleteAccountResponse(
      isSuccess: json['is_success'] ?? false,
      
    details:ResponseDetails.fromJson(json["details"]),
    );
  }

}