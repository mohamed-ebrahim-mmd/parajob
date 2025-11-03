/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 03/11/2025 1:35 PM
 ==================================================================
*/

import 'package:para_job/packages/api_client/src/models/responses/faculty.dart';

class FacultyResponse {
  final List<Faculty> data;
  final bool isSuccess;

  FacultyResponse({
    required this.data,
    required this.isSuccess,
  });

  factory FacultyResponse.fromJson(Map<String, dynamic> json) {
    return FacultyResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Faculty.fromJson(e))
          .toList(),
      isSuccess: json['is_success'] ?? false,
    );
  }
}

