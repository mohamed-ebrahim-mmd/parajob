/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 24/11/2025 4:23 PM
 ==================================================================
*/
class AppleAuthRequest {
  final String identityToken;

  AppleAuthRequest({required this.identityToken});

  Map<String, dynamic> toJson() {
    return {"token": identityToken};
  }
}
