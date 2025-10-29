import 'meta.dart';
import 'my_notification.dart';

class MyNotificationsResponse {
  final List<MyNotification> data;
  final Meta meta;
  final int unreadNotificationsCount;
  final bool isSuccess;

  MyNotificationsResponse({
    required this.data,
    required this.meta,
    required this.unreadNotificationsCount,
    required this.isSuccess,
  });

  factory MyNotificationsResponse.fromJson(Map<String, dynamic> json) {
    return MyNotificationsResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MyNotification.fromJson(e))
          .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] ?? {}),
      unreadNotificationsCount: json['unread_notifications_count'] ?? 0,
      isSuccess: json['is_success'] ?? false,
    );
  }
}


