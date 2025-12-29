/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 24/11/2025 4:17 PM
 ==================================================================
*/

import 'package:para_job/packages/api_client/src/models/responses/google_auth_response.dart';
import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class AppleAuthResponse {
  final AuthData? authData; // renamed from 'data'
  final bool isSuccess;
  final ResponseDetails? details;

  AppleAuthResponse({
    required this.authData,
    required this.isSuccess,
    required this.details,
  });

  factory AppleAuthResponse.fromJson(Map<String, dynamic> json) {
    return AppleAuthResponse(
      authData: json['data'] != null && json['data'].isNotEmpty
          ? AuthData.fromJson(json['data'])
          : null,
      isSuccess: json['is_success'] ?? false,
      details: ResponseDetails.fromJson(json['details']),
    );
  }
}
