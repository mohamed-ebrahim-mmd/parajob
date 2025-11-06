//
//  @ Header: @Author: mary.mark@moselaymd.com |

import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class BookmarkedJobsController extends GetxController {
  /// Paging controller for infinite scroll pagination
  late final PagingController<int, Job> pagingController;

  /// Authentication token retrieved from user controller
  final String token = Get.find<UserController>().token!;

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
      fetchPage: _fetchBookmarkPage,
    );
  }

  /// Fetches bookmarked jobs from API (single page)
  Future<List<Job>> _fetchBookmarkPage(int pageKey) async {
    log('📄 Fetching bookmarked jobs (page: $pageKey)');

    final response = await apiClient.fetchBookmark(token: token, page: pageKey);

    if (response.isSuccess) {
      return response.data ?? [];
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
