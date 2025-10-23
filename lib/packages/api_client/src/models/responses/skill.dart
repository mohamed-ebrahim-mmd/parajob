/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-23 11:27 AM
 ==================================================================
*/
class Skill {
  final int id;
  final String name;

  Skill({required this.id, required this.name});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(id: json['id'], name: json['name'] ?? '');
  }
}
