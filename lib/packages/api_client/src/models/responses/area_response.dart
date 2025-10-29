/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-26 2:40 PM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/responses/area.dart';

class AreaResponse {
  final List<Area> data;
  final bool isSuccess;

  AreaResponse({required this.data, required this.isSuccess});

  factory AreaResponse.fromJson(Map<String, dynamic> json) {
    return AreaResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Area.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSuccess: json['is_success'] as bool,
    );
  }
}
