/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-23 11:27 AM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/responses/skill.dart';

class SkillResponse {
  final List<Skill> data;
  final bool isSuccess;

  SkillResponse({required this.data, required this.isSuccess});

  factory SkillResponse.fromJson(Map<String, dynamic> json) {
    return SkillResponse(
      data: (json['data'] as List<dynamic>)
          .map((item) => Skill.fromJson(item))
          .toList(),
      isSuccess: json['is_success'] ?? false,
    );
  }
}
