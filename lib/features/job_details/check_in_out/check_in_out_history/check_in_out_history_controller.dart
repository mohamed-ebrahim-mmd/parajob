import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:para_job/packages/api_client/api_client.dart';

import '../../../../packages/api_client/src/models/responses/check_in_out_history.dart';
import '../../../../packages/user_manager/user_controller.dart';


class CheckInOutHistoryController extends GetxController {
  final int jobId;

  CheckInOutHistoryController({ required this.jobId});
  final String token = Get.find<UserController>().token!;

  late final PagingController<int, CheckInOutHistory> pagingController;

  @override
  void onInit() {
    super.onInit();
    _initPagingController();
  }

  void _initPagingController() {
    pagingController = PagingController<int, CheckInOutHistory>(
      getNextPageKey: (state) =>
      state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) {
        return getCheckInOutHistory(jobId: jobId, page: pageKey);
      },
    );
  }

  Future<List<CheckInOutHistory>> getCheckInOutHistory({
    required int jobId,
    int page = 1,
  }) async {
    final response = await apiClient.getCheckInOutHistory(
        jobId: jobId,
        page: page,
        token: token
    );
    return response.data ?? [];
  }

  String calculateWorkedHours(DateTime? checkIn, DateTime? checkOut) {
    if (checkIn == null || checkOut == null) return '--';

    final duration = checkOut.difference(checkIn);

    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (minutes == 0) {
      return '${hours}h';
    } else {
      return '${hours}h ${minutes}m';
    }
  }

}
