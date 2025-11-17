/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com |
 ==================================================================
*/

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class ActiveJobsController extends GetxController {
  final int companyId;

  /// Paging controller for infinite scroll pagination
  late final PagingController<int, Job> pagingController;

  /// Authentication token retrieved from user controller
  final String token = Get.find<UserController>().token!;

  ActiveJobsController({required this.companyId});

  @override
  void onInit() {
    super.onInit();
    initPagingController();
  }

  /// Initialize pagination logic
  void initPagingController() {
    pagingController = PagingController<int, Job>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: _fetchActiveJobs,
    );
  }

  Future<List<Job>> _fetchActiveJobs(int pageKey) async {
    final response = await apiClient.fetchJobs(
      token: token,
      page: pageKey,
      companyId: companyId,
    );

    if (response.isSuccess ?? false) {
      return response.data ?? [];
    } else {
      throw Exception("fetch_jobs_failed".tr);
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
