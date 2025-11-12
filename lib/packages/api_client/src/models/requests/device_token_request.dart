// Karim Toson || kareemtoson1@gmail.com || 12/11/2025 3:50 PM

class DeviceTokenRequest {
  final String deviceToken;

  DeviceTokenRequest({required this.deviceToken});

  // Convert Dart object → JSON
  Map<String, dynamic> toJson() {
    return {'device_token': deviceToken};
  }
}
