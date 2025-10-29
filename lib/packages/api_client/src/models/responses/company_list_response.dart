/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-23 11:38 AM
 ==================================================================
*/
import 'package:para_job/packages/api_client/src/models/responses/company_list_item.dart'
    show CompanyListItem;

class CompanyListResponse {
  final List<CompanyListItem> data;
  final bool isSuccess;

  CompanyListResponse({required this.data, required this.isSuccess});

  factory CompanyListResponse.fromJson(Map<String, dynamic> json) {
    return CompanyListResponse(
      data: (json['data'] as List<dynamic>)
          .map((item) => CompanyListItem.fromJson(item))
          .toList(),
      isSuccess: json['is_success'] ?? false,
    );
  }
}
