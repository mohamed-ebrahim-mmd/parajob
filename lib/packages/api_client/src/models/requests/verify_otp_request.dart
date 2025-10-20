/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-20 2:01 PM
 ==================================================================
*/
class VerifyOtpRequest {
  final String phoneNumber;
  final String otp;

  VerifyOtpRequest({required this.phoneNumber, required this.otp});

  Map<String, dynamic> toJson() {
    return {'phone_number': phoneNumber, 'otp': otp};
  }
}
