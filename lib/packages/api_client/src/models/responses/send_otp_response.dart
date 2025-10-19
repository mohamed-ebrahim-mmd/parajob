/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-19 3:27 PM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/responses/response_details.dart'
    show ResponseDetails;

class SendOtpResponse {
  final Map<String, dynamic>? data;
  final bool? isSuccess;
  final ResponseDetails? details;

  SendOtpResponse({this.data, this.isSuccess, this.details});

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      data: json['data'] != null
          ? Map<String, dynamic>.from(json['data'])
          : null,
      isSuccess: json['is_success'],
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }
}
