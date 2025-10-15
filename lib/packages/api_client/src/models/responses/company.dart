/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-15 3:25 PM
 ==================================================================
*/
class Company {
  final int id;
  final String name;
  final String logo;

  Company({required this.id, required this.name, required this.logo});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(id: json['id'], name: json['name'], logo: json['logo']);
  }
}
