import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/api_client/src/models/responses/my_notification.dart';

import '../../packages/user_manager/user_controller.dart';

class MyNotificationController extends GetxController {
  final token = Get.find<UserController>().token!;

  String getSectionLabel(DateTime date, DateTime now) {
    final diff = now.difference(date).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return 'Earlier';
  }

  Future<List<MyNotification>> getNotifications({
    int page = 1,
  }) async {
    final response = await apiClient.getNotifications(page: page, token: token);

    return response.data;
  }
}
