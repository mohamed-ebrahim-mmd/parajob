import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class Contract {
  final int id;
  final String title;
  final String content;
  final String imageUrl;

  Contract({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}


class ContractResponse {
  final Contract data;
  final bool isSuccess;
  final ResponseDetails? details;

  ContractResponse({
    required this.data,
    required this.isSuccess,
    this.details,
  });

  factory ContractResponse.fromJson(Map<String, dynamic> json) {
    return ContractResponse(
      data: Contract.fromJson(json['data']),
      isSuccess: json['is_success'] ?? false,
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }
}

