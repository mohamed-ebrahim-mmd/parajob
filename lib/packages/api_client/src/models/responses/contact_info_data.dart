class ContactInfoData {
  final String email;
  final String phoneNumber;

  ContactInfoData({
    required this.email,
    required this.phoneNumber,
  });

  factory ContactInfoData.fromJson(Map<String, dynamic> json) {
    return ContactInfoData(
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }

}