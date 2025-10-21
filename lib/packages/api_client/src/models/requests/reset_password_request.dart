/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-20 5:28 PM
 ==================================================================
*/
class ResetPasswordRequest {
  final String phoneNumber;
  final String password;
  final String passwordConfirmation;

  ResetPasswordRequest({
    required this.phoneNumber,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}
