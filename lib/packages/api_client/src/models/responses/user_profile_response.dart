import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';
import 'package:para_job/packages/api_client/src/models/responses/user_profile_data.dart';

class UserProfileResponse {
  final UserProfileData? data;
  final bool? isSuccess;
  final ResponseDetails? details;

  UserProfileResponse({
    this.data,
    this.isSuccess,
    this.details,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      data: json['data'] != null
          ? UserProfileData.fromJson(json['data'])
          : null,
      isSuccess: json['is_success'] ?? false,
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }


}

