/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-20 2:01 PM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class VerifyOtpResponse {
  final Map<String, dynamic>? data;
  final bool? isSuccess;
  final ResponseDetails? details;

  VerifyOtpResponse({this.data, this.isSuccess, this.details});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
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
