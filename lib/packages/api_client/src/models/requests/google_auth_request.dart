/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 24/11/2025 4:23 PM
 ==================================================================
*/
class GoogleAuthRequest {
  final String accessToken;

  GoogleAuthRequest({required this.accessToken});

  Map<String, dynamic> toJson() {
    return {"token": accessToken};
  }
}
