import 'package:para_job/packages/api_client/src/models/responses/about_us_data.dart';
import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class AboutUsResponse {
  final AboutUsData data;
  final bool isSuccess;
  final ResponseDetails details;

  AboutUsResponse({
    required this.data,
    required this.isSuccess,
    required this.details,
  });

  factory AboutUsResponse.fromJson(Map<String, dynamic> json) {
    return AboutUsResponse(
        data: AboutUsData.fromJson(json['data']),
      isSuccess: json['is_success'] ?? false,
      details: ResponseDetails.fromJson(json['details']),
    );
  }


}


