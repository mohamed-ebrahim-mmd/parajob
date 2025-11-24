class CheckInOutHistory {
  final DateTime? checkInAt;
  DateTime? checkOutAt;
  final DateTime? attendanceDate;
  final JobPartial? job;
  double? extraTime;

  CheckInOutHistory({
    this.checkInAt,
    this.checkOutAt,
    this.attendanceDate,
    this.job,
    this.extraTime,
  });

  factory CheckInOutHistory.fromJson(Map<String, dynamic>? json) {
    return CheckInOutHistory(
      checkInAt: json?['check_in_at'] != null
          ? DateTime.parse(json?['check_in_at'])
          : null,
      checkOutAt: json?['check_out_at'] != null
          ? DateTime.parse(json?['check_out_at'])
          : null,
      attendanceDate: json?['attendance_date'] != null
          ? DateTime.parse(json?['attendance_date'])
          : null,
      job: json?['job'] != null ? JobPartial.fromJson(json!['job']) : null,
      extraTime: json?['extra_time'] != null
          ? (json!['extra_time'] as num).toDouble()
          : null,
    );
  }
}

class JobPartial {
  final String? from;
  final String? to;

  JobPartial({this.from, this.to});

  factory JobPartial.fromJson(Map<String, dynamic> json) {
    return JobPartial(from: json['from'], to: json['to']);
  }
}
