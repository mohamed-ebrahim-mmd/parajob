/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-21 11:06 AM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/models.dart';


class DepartmentResponse {
  final List<Department> data;
  final bool? isSuccess;
  final ResponseDetails? details;

  DepartmentResponse({required this.data, this.isSuccess, this.details});

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) {
    return DepartmentResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Department.fromJson(e))
          .toList(),
      isSuccess: json['is_success'],
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }
}
