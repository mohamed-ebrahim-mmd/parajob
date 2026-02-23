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
        Get.toNamed(
          '${Routes.mainNavigator}${Routes.interview}',
          arguments: {'id': details.modelId},
        );
        break;

      case 'strike':
        Get.toNamed(
          '${Routes.mainNavigator}${Routes.notificationStrikeScreen}',
        );
        break;
    }
  }
}
