/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-30 11:06 AM
 ==================================================================
*/

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/packages/api_client/src/models/responses/my_notification.dart';
import 'package:para_job/packages/user_manager/user_controller.dart'
    show UserController;

import '../../packages/api_client/src/service/api_client_instance.dart';

String getSectionLabel(DateTime date, DateTime now) {
  final diff = now.difference(date).inDays;
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  return 'Earlier';
}

/// Initializes the paging controller and sets up pagination logic
PagingController<int, MyNotification> initPagingController() {
  return PagingController<int, MyNotification>(
    getNextPageKey: (state) =>
        state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => getNotifications(pageKey),
  );
}

Future<List<MyNotification>> getNotifications(int page) async {
  final response = await apiClient.getNotifications(
    page: page,
    token: Get.find<UserController>().token!,
  );

  return response.data;
}
