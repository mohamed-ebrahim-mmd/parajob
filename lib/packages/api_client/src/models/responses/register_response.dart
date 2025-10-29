/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-28 11:58 AM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';
import 'package:para_job/packages/api_client/src/models/responses/user.dart';

class RegisterResponse {
  final RegisterData? data;
  final bool? isSuccess;
  final ResponseDetails? details;

  RegisterResponse({this.data, this.isSuccess, this.details});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      data: json['data'] != null ? RegisterData.fromJson(json['data']) : null,
      isSuccess: json['is_success'],
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }
}

class RegisterData {
  final String? token;
  final User? user;

  RegisterData({this.token, this.user});

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}
