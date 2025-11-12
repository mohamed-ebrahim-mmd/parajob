import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/packages/api_client/api_client.dart';

import '../../../packages/api_client/src/models/responses/review.dart';

class EmployerReviewsController extends GetxController {
  final int companyId;
  final RxDouble averageRating = 0.0.obs;

  EmployerReviewsController(this.companyId);

  late final PagingController<int, Review> pagingController;

  @override
  void onInit() {
    super.onInit();
    _initPagingController();
  }

  void _initPagingController() {
    pagingController = PagingController<int, Review>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) {
        return fetchCompanyReviews(companyId: companyId, page: pageKey);
      },
    );
  }

  Future<List<Review>> fetchCompanyReviews({
    required int companyId,
    int page = 1,
  }) async {
    final response = await apiClient.fetchCompanyReviews(
      companyId: companyId,
      page: page,
    );
    if (page == 1) {
      averageRating.value = response.averageRate ?? 0.0;
    }
    return response.data ?? [];
  }
}
