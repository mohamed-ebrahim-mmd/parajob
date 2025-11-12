// Karim Toson || kareemtoson1@gmail.com || Wed Nov 12 2025 15:59:19
class DeviceTokenResponse {
  final Map<String, dynamic>? data;
  final bool isSuccess;
  final DeviceTokenResponseDetails details;

  DeviceTokenResponse({
    this.data,
    required this.isSuccess,
    required this.details,
  });

  factory DeviceTokenResponse.fromJson(Map<String, dynamic> json) {
    return DeviceTokenResponse(
      data: json['data'] != null
          ? Map<String, dynamic>.from(json['data'])
          : null,
      isSuccess: json['is_success'] ?? false,
      details: DeviceTokenResponseDetails.fromJson(json['details']),
    );
  }
}

class DeviceTokenResponseDetails {
  final int statusCode;
  final String message;
  final dynamic validationErrors;

  DeviceTokenResponseDetails({
    required this.statusCode,
    required this.message,
    this.validationErrors,
  });

  factory DeviceTokenResponseDetails.fromJson(Map<String, dynamic> json) {
    return DeviceTokenResponseDetails(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      validationErrors: json['validation_errors'],
    );
  }
}
