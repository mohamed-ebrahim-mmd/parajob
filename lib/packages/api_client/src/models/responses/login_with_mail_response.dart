/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-19 9:40 AM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';
import 'package:para_job/packages/api_client/src/models/responses/user.dart';

class LoginWithMailResponse {
  final LoginData? data;
  final bool? isSuccess;
  final ResponseDetails? details;

  LoginWithMailResponse({this.data, this.isSuccess, this.details});

  factory LoginWithMailResponse.fromJson(Map<String, dynamic> json) {
    return LoginWithMailResponse(
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
      isSuccess: json['is_success'],
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }
}

class LoginData {
  final String? token;
  final User? user;

  LoginData({this.token, this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}
