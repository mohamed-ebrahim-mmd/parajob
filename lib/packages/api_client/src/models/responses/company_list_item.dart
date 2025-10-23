/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-23 11:37 AM
 ==================================================================
*/
class CompanyListItem {
  final int id;
  final String name;

  CompanyListItem({required this.id, required this.name});

  factory CompanyListItem.fromJson(Map<String, dynamic> json) {
    return CompanyListItem(id: json['id'], name: json['name'] ?? '');
  }
}
