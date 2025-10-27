import 'package:para_job/packages/api_client/src/models/responses/about_us_data.dart';

class AboutUsResponse {
  final AboutUsData data;
  final bool isSuccess;

  AboutUsResponse({required this.data, required this.isSuccess});

  factory AboutUsResponse.fromJson(Map<String, dynamic> json) {
    return AboutUsResponse(
      data: AboutUsData.fromJson(json['data']),
      isSuccess: json['is_success'] ?? false,
    );
  }
}
