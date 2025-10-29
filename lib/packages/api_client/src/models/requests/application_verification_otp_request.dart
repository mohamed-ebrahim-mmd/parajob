
class ApplicationVerificationOtpRequest {
  final String otp;

  ApplicationVerificationOtpRequest({required this.otp});

  Map<String, dynamic> toJson() {
    return { 'otp': otp};
  }
}
