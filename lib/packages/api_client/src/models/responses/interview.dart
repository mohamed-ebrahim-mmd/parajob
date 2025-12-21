class Interview {
  final int id;

  Interview({required this.id});

  factory Interview.fromJson(Map<String, dynamic> json) {
    return Interview(id: json['id'] ?? 0);
  }
}
