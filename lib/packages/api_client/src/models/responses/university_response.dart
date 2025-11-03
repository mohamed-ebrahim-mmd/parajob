/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 03/11/2025 1:32 PM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/responses/university.dart';

class UniversityResponse {
  final List<University> data;
  final bool isSuccess;


  UniversityResponse({
    required this.data,
    required this.isSuccess,

  });

  factory UniversityResponse.fromJson(Map<String, dynamic> json) {
    return UniversityResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => University.fromJson(e))
          .toList(),
      isSuccess: json['is_success'] ?? false,

    );
  }
}
