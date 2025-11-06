import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class BookmarkedJobsController extends GetxController {
  BookmarkedJobsController();
  var pookmarkedCallState = ApiCallState.loading.obs;

  late final pagingController;
  final String token = Get.find<UserController>().token!;
  BookmarkedJobsResponse? bookmarkedJobsResponse;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // initPagingController();
    //  pookmarkedCallState.value = ApiCallState.success;
    fetchBookmark(1);
    initPagingController();
  }

  /// Initialize pagination logic (runs only after departments are loaded)
  void initPagingController() {
    // pookmarkedCallState.value = ApiCallState.loading;

    pagingController = PagingController<int, Job>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,

      fetchPage: fetchBookmark,
    );
  }

  Future<List<Job>> fetchBookmark(int pageKey) async {
    pookmarkedCallState.value = ApiCallState.loading;
    try {
      final response = await apiClient.fetchBookmark(token: token);

      if (response.isSuccess) {
        log("🟢 isSuccess");

        bookmarkedJobsResponse = response;

        pookmarkedCallState.value = ApiCallState.success;
        return response.data ?? [];
      } else {
        pookmarkedCallState.value = ApiCallState.failure;
        return [];
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      pookmarkedCallState.value = ApiCallState.failure;
      return [];
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
