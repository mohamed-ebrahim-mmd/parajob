

import 'package:para_job/packages/api_client/src/models/models.dart';

class UserProfileResponse {
  final UserProfileData data;
  final bool isSuccess;
  final ResponseDetails details;

  UserProfileResponse({

  
    required this.data,
    required this.details,
    required this.isSuccess, 
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      data: UserProfileData.fromJson(json['data']),
      isSuccess: json['is_success'] ?? false,
      details: ResponseDetails.fromJson(json['details']),
    );
  }


}

