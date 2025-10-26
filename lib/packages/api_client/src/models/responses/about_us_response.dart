import 'package:para_job/packages/api_client/src/models/responses/about_us_data.dart';
import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class AboutUsResponse {
  final AboutUsData? data;
  final bool? isSuccess;
  final ResponseDetails? details;

  AboutUsResponse({
    this.data,
    this.isSuccess,
    this.details,
  });

  factory AboutUsResponse.fromJson(Map<String, dynamic> json) {
    return AboutUsResponse(
      data: json['data'] != null ? AboutUsData.fromJson(json['data']) : null,
      isSuccess: json['is_success'],
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }


}


