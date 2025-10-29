/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-26 2:44 PM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/responses/city.dart';

class CityResponse {
  final List<City> data;
  final bool isSuccess;

  CityResponse({required this.data, required this.isSuccess});

  factory CityResponse.fromJson(Map<String, dynamic> json) {
    return CityResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => City.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSuccess: json['is_success'] as bool,
    );
  }
}
