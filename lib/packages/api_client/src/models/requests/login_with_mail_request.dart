/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-19 9:38 AM
 ==================================================================
*/
class LoginWithMailRequest {
  final String email;
  final String password;

  LoginWithMailRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
