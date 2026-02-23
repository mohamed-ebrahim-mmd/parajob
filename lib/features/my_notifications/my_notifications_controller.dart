/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-30 11:30 AM
 ==================================================================
*/

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/packages/api_client/src/models/responses/my_notification.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import '../../packages/api_client/src/service/api_client_instance.dart';
import '../../packages/route_manager/controller/routes.dart';

class MyNotificationsController extends GetxController {
  late final PagingController<int, MyNotification> pagingController;

  @override
  void onInit() {
    super.onInit();
    pagingController = initPagingController();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
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

  Future<bool> markAsRead(int id) async {
    // OPTIMISTIC UPDATE: Update the local list immediately
    pagingController.mapItems((notification) {
      if (notification.id == id) {
        return notification.copyWith(readAt: "now");
      }
      return notification;
    });

    try {
      final token = Get.find<UserController>().token;
      final response = await apiClient.markNotificationAsRead(
        token: token ?? "",
        id: id,
      );

      return response.isSuccess;
      // Note: We don't need to call pagingController.mapItems here anymore
      // because we already did it above!
    } catch (e) {
      // Optional: If the API fails, you could revert the read state here
      // by mapping the items again, but for 'read' status, users rarely notice.
      return false;
    }
  }

  String getSectionLabel(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    if (diff == 0) return 'notification_today'.tr;
    if (diff == 1) return 'notification_yesterday'.tr;
    return 'notification_earlier'.tr;
  }

  void handleNotificationTap({required MyNotification myNotification}) {
    final details = myNotification.details;

    if (details.jobId?.isNotEmpty != true) return;

    switch (myNotification.type) {
      case 'interview':
        // 1. Mark as read in the background (fire and forget)
        if (myNotification.readAt == null) {
          markAsRead(myNotification.id);
          // We don't 'await' here because we want the navigation below to happen INSTANTLY
        }
        Get.toNamed(
          '${Routes.mainNavigator}${Routes.interview}',
          arguments: {'id': details.modelId},
        );
        break;

      case 'strike':
        // 1. Mark as read in the background (fire and forget)
        if (myNotification.readAt == null) {
          markAsRead(myNotification.id);
          // We don't 'await' here because we want the navigation below to happen INSTANTLY
        }
        Get.toNamed(
          '${Routes.mainNavigator}${Routes.notificationStrikeScreen}',
        );
        break;
    }
  }
}
