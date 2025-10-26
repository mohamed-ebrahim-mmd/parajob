/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-26 2:39 PM
 ==================================================================
*/

class Area {
  final int id;
  final String name;

  Area({required this.id, required this.name});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(id: json['id'] as int, name: json['name'] as String);
  }
}
