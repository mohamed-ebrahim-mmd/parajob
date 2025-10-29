import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

import 'company.dart';

class CompanyResponse {
  final Company? data;
  final bool isSuccess;
  final ResponseDetails? details;

  CompanyResponse({
    this.data,
    required this.isSuccess,
    this.details,
  });

  factory CompanyResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CompanyResponse(isSuccess: false);

    return CompanyResponse(
      data: json['data'] != null ? Company.fromJson(json['data']) : null,
      isSuccess: json['is_success'],
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }
}
