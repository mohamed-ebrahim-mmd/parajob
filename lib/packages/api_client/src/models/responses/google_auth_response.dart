/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 24/11/2025 4:17 PM
 ==================================================================
*/

import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';
import 'package:para_job/packages/api_client/src/models/responses/user.dart';

class GoogleAuthResponse {
  final AuthData? authData; // renamed from 'data'
  final bool isSuccess;
  final ResponseDetails? details;

  GoogleAuthResponse({
    required this.authData,
    required this.isSuccess,
    required this.details,
  });

  factory GoogleAuthResponse.fromJson(Map<String, dynamic> json) {
    return GoogleAuthResponse(
      authData: json['data'] != null && json['data'].isNotEmpty
          ? AuthData.fromJson(json['data'])
          : null,
      isSuccess: json['is_success'] ?? false,
      details: ResponseDetails.fromJson(json['details']),
    );
  }
}

class AuthData {
  final String accessToken;
  final User user;

  AuthData({required this.accessToken, required this.user});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      accessToken: json['token'] ?? '',
      user: User.fromJson(json['user']),
    );
  }
}
