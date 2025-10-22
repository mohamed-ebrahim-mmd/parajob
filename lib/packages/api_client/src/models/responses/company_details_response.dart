import 'package:para_job/packages/api_client/api_client.dart';

class CompanyDetailsResponse {
  final CompanyData data;
  final bool isSuccess;
  final ResponseDetails details;

  CompanyDetailsResponse({
    required this.data,
    required this.isSuccess,
    required this.details,
  });

  factory CompanyDetailsResponse.fromJson(Map<String, dynamic> json) =>
      CompanyDetailsResponse(
        details: ResponseDetails.fromJson(json["details"]),
        data: CompanyData.fromJson(json['data']),
        isSuccess: json['is_success'] ?? false,
      );
}
