class Reviewer {
  final int id;
  final String name;

  Reviewer({required this.id, required this.name});

  factory Reviewer.fromJson(Map<String, dynamic> json) {
    return Reviewer(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
