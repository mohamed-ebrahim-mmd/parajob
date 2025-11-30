import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

import 'check_in_out_history.dart';
import 'meta.dart';

class CheckInOutHistoryResponse {
  final List<CheckInOutHistory>? data;
  final Meta? meta;
  final bool isSuccess;
  final ResponseDetails? details;

  CheckInOutHistoryResponse({
    this.data,
    this.meta,
    required this.isSuccess,
    this.details,
  });

  factory CheckInOutHistoryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CheckInOutHistoryResponse(isSuccess: false);

    var dataJson = json['data'] as List<dynamic>?;

    return CheckInOutHistoryResponse(
      data: dataJson?.map((e) => CheckInOutHistory.fromJson(e)).toList(),
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      isSuccess: json['is_success'] ?? false,
      details: json['details'] != null
          ? ResponseDetails.fromJson(json['details'])
          : null,
    );
  }
}
