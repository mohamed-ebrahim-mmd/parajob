//Mary Mark ||  mary.mark@moselaymd.com || Mon Nov 10 2025 16:18:33

//
//  @ Header: @Author: mary.mark@moselaymd.com |

import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/api_client/src/enums/job_application_status.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class HistoryJobsController extends GetxController {
  /// Paging controller for infinite scroll pagination
  late final PagingController<int, MyJob> pagingController;

  /// Authentication token retrieved from user controller
  final String token = Get.find<UserController>().token!;

  @override
  void onInit() {
    super.onInit();
    initPagingController();
  }

  /// Initialize pagination logic
  void initPagingController() {
    pagingController = PagingController<int, MyJob>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: _fetchJobHistoryPage,
    );
  }

  /// Fetches  jobs from API (single page)
  Future<List<MyJob>> _fetchJobHistoryPage(int pageKey) async {
    log('📄 Fetching  jobs (page: $pageKey)');

    final response = await apiClient.fetchMyJobs(
      token: token,
      page: pageKey,
      perPage: pageKey,
      status: JobApplicationStatus.accepted.value,
    );

    if (response.isSuccess) {
      return response.data;
    } else {
      throw Exception('Failed to fetch jobs');
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
