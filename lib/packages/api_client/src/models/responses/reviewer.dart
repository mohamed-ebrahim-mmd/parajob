
class Reviwer {
  final int id;
  final String name;

  Reviwer({
    required this.id,
    required this.name,
  });

  factory Reviwer.fromJson(Map<String, dynamic> json) {
    return Reviwer(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}