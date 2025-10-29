import 'package:para_job/packages/api_client/src/models/responses/response_details.dart';

class DeleteUserPhoto {
  final bool isSuccess;
  final ResponseDetails details;

  DeleteUserPhoto({required this.isSuccess, required this.details});

  factory DeleteUserPhoto.fromJson(Map<String, dynamic> json) {
    return DeleteUserPhoto(
      isSuccess: json['is_success'] ?? false,

      details: ResponseDetails.fromJson(json["details"]),
    );
  }
}
