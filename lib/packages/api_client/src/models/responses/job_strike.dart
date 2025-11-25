//Mary Mark ||  mary.mark@moselaymd.com || Thu Nov 20 2025 17:35:41

class JobStrike {
  final int id;
  final String title;
  final String salary;
  final String startDate;

  JobStrike({
    required this.id,
    required this.title,
    required this.salary,
    required this.startDate,
  });

  factory JobStrike.fromJson(Map<String, dynamic> json) {
    return JobStrike(
      id: json["id"],
      title: json["title"],
      salary: json["salary"],
      startDate: json["start_date"],
    );
  }
}