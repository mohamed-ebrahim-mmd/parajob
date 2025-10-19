/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-19 3:27 PM
 ==================================================================
*/
class SendOtpRequest {
  final String phoneNumber;

  SendOtpRequest({required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {'phone_number': phoneNumber};
  }
}
