
class JobCompany {
  final int? id;
  final String? name;
  final String? logo;

  JobCompany({
    this.id,
    this.name,
    this.logo,
  });

  factory JobCompany.fromJson(Map<String, dynamic> json) => JobCompany(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
      );
}


