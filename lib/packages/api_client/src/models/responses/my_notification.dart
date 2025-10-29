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
}
