/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-19 9:41 AM
 ==================================================================
*/
class ResponseDetails {
  final int? statusCode;
  final String? message;
  final dynamic validationErrors;

  ResponseDetails({this.statusCode, this.message, this.validationErrors});

  factory ResponseDetails.fromJson(Map<String, dynamic> json) {
    return ResponseDetails(
      statusCode: json['status_code'],
      message: json['message'],
      validationErrors: json['validation_errors'],
    );
  }
}
