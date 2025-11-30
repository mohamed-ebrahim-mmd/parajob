import 'package:para_job/packages/api_client/src/models/models.dart';
import 'package:para_job/packages/api_client/src/models/responses/check_in_out_history.dart';

class ActiveCheckInOutResponse {
  final CheckInOutHistory data;
  final bool isSuccess;
  final ResponseDetails details;

  ActiveCheckInOutResponse({
    required this.data,
    required this.isSuccess,
    required this.details,
  });

  factory ActiveCheckInOutResponse.fromJson(Map<String, dynamic> json) {
    return ActiveCheckInOutResponse(
      data: CheckInOutHistory.fromJson(json['data']),
      isSuccess: json['is_success'] ?? false,
      details: ResponseDetails.fromJson(json['details']),
    );
  }
}
