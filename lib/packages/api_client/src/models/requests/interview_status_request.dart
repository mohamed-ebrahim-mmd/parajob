//Mary Mark ||  mary.mark@moselaymd.com || Wed Dec 03 2025 13:39:15

import 'package:para_job/packages/api_client/src/enums/interview_status_enum.dart';

class InterviewStatusRequest {
  final InterviewStatusEnum userResponse;

  InterviewStatusRequest({required this.userResponse});

  Map<String, dynamic> toJson() {
    return {'user_response': userResponse.value};
  }
}
