class Department {
  final int? id; // make nullable
  final String name;

  Department({required this.id, required this.name});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(id: json['id'] ?? -1, name: json['name'] ?? '');
  }
}
