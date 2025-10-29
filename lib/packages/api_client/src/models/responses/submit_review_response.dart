import 'package:para_job/packages/api_client/src/models/responses/response_details.dart'
    show ResponseDetails;

class SubmitReviewResponse {
  final Map<String, dynamic>? data;
  final bool? isSuccess;
  final ResponseDetails? details;

  SubmitReviewResponse({this.data, this.isSuccess, this.details});

  factory SubmitReviewResponse.fromJson(Map<String, dynamic> json) {
    return SubmitReviewResponse(
      data: json['data'] != null
          ? Map<String, dynamic>.from(json['data'])
          : null,
      isSuccess: json['is_success'],
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }
}
