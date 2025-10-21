/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-20 5:28 PM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class ResetPasswordResponse {
  final Map<String, dynamic>? data;
  final bool? isSuccess;
  final ResponseDetails? details;

  ResetPasswordResponse({this.data, this.isSuccess, this.details});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
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
