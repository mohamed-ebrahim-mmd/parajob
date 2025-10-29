import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class ContactUsResponse {
 
  final bool isSuccess;
  final ResponseDetails details;

  ContactUsResponse({
   
    required this.isSuccess,
    required this.details,
  });

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) {
    return ContactUsResponse(
      isSuccess: json["is_success"] ?? false,
      details: ResponseDetails.fromJson(json["details"] ?? {}),
    );
  }
}
