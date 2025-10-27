class ContactUsInfoData {
  final String email;
  final String phoneNumber;

  ContactUsInfoData({
    required this.email,
    required this.phoneNumber,
  });

  factory ContactUsInfoData.fromJson(Map<String, dynamic> json) {
    return ContactUsInfoData(
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }

}