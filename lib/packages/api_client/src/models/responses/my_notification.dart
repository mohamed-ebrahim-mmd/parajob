import 'my_notification_details.dart';

class MyNotification {
  final int id;
  final MyNotificationDetails details;
  final String? readAt;
  final String type;
  final String createdAt;

  MyNotification({
    required this.id,
    required this.details,
    required this.readAt,
    required this.type,
    required this.createdAt,
  });

  factory MyNotification.fromJson(Map<String, dynamic> json) {
    return MyNotification(
      id: json['id'] ?? 0,
      details: MyNotificationDetails.fromJson(json['details'] ?? {}),
      readAt: json['read_at'],
      type: json['type'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  MyNotification copyWith({
    int? id,
    MyNotificationDetails? details,
    String? readAt,
    String? type,
    String? createdAt,
  }) {
    return MyNotification(
      id: id ?? this.id,
      details: details ?? this.details,
      readAt: readAt ?? this.readAt,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
