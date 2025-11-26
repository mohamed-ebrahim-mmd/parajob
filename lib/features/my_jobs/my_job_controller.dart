//Mary Mark ||  mary.mark@moselaymd.com || Wed Nov 26 2025 15:24:09


import 'dart:developer';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/api_client/src/enums/job_application_status.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class MyJobsController extends GetxController {
  late PagingController<int, MyJob> pagingController;

  /// Authentication token retrieved from user controller
  final String token = Get.find<UserController>().token!;

  @override
  void onInit() {
    super.onInit();
    pagingController = initPagingController(null);
  }

  Future<List<MyJob>> fetchMyJobsPage({
    JobApplicationStatus? status,
    required int page,
  }) async {
    log("📄fech jobs");
    final response = await apiClient.fetchMyJobs(
      status: status?.value,
      page: page,
      token: Get.find<UserController>().token!,
    );

    return response.data;
  }

  PagingController<int, MyJob> initPagingController(
    JobApplicationStatus? status,
  ) {
    return PagingController<int, MyJob>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) {
        return fetchMyJobsPage(status: status, page: pageKey);
      },
    );
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
