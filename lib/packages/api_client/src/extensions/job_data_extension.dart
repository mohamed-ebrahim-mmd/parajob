// Karim Toson || kareemtoson1@gmail.com || Sun Nov 17 2025 11:17:00

import 'package:get/get.dart';
import 'package:para_job/packages/api_client/src/models/responses/job_data.dart';

extension JobDataTypeExtension on JobData {
  String get displayType {
    // Map the job type to a localized string
    switch (type.toLowerCase()) {
      case 'full_time':
        return 'job_type_full_time'.tr;
      case 'part_time':
        return 'job_type_part_time'.tr;

      default:
        // Return the original type if no mapping is found
        return type;
    }
  }
}
