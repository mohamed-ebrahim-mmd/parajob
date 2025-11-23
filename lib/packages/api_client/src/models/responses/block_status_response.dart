//Mary Mark ||  mary.mark@moselaymd.com || Thu Nov 20 2025 14:19:58

import 'package:para_job/packages/api_client/src/models/responses/block_status_data.dart';

class BlockStatusResponse {
  final BlockStatusData? data;
  final bool isSuccess;

  BlockStatusResponse({required this.data, required this.isSuccess});

  factory BlockStatusResponse.fromJson(Map<String, dynamic> json) {
    return BlockStatusResponse(
      data: json['data'] != null
          ? BlockStatusData.fromJson(json['data'])
          : null,
      isSuccess: json['is_success'] ?? false,
    );
  }
}
