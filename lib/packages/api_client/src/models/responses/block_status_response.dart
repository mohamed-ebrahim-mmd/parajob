//Mary Mark ||  mary.mark@moselaymd.com || Thu Nov 20 2025 14:19:58

import 'package:para_job/packages/api_client/src/models/responses/block_status_data.dart';

class BlockStatus {
  final BlockStatusData? data;
  final bool isSuccess;
 
  BlockStatus({
    required this.data,
    required this.isSuccess,
  });

  factory BlockStatus.fromJson(Map<String, dynamic> json) {
    return BlockStatus(
      data: json['data'] != null
          ? BlockStatusData.fromJson(json['data'])
          : null,
      isSuccess: json['is_success'] ?? false,
    
    );
  }
}



