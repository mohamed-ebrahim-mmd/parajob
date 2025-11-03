/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 03/11/2025 1:35 PM
 ==================================================================
*/
class Faculty {
  final int id;
  final String name;

  Faculty({
    required this.id,
    required this.name,
  });

  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
