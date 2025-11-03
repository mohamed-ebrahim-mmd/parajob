/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 03/11/2025 1:31 PM
 ==================================================================
*/
class University {
  final int id;
  final String name;

  University({
    required this.id,
    required this.name,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
