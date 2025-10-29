import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';

import '../../../packages/api_client/src/models/responses/review.dart';

class EmployerReviewsController extends GetxController {
  final int companyId;
  final RxDouble averageRating = 0.0.obs;

  EmployerReviewsController(this.companyId);

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
