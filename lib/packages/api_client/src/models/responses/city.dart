class City {
  final int? id;
  final String? name;

  City({this.id, this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] == null || json['id'].toString().isEmpty
          ? null
          : int.tryParse(json['id'].toString()),
      name: json['name']?.toString() ?? '',
    );
  }
}
