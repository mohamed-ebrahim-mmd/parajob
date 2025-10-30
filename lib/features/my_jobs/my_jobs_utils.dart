/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-30 2:03 PM
 ==================================================================
*/
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:para_job/packages/api_client/src/enums/job_application_status.dart';
import 'package:para_job/packages/api_client/src/models/responses/my_job.dart';
import 'package:para_job/packages/api_client/src/service/api_client_instance.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

Future<List<MyJob>> fetchMyJobsPage({
  JobApplicationStatus? status,
  required int page,
}) async {
  final response = await apiClient.fetchMyJobs(
    status: status?.value,
    page: page,
    token: Get.find<UserController>().token!,
  );

  return response.data;
}

Map<String, List<dynamic>> groupJobsByMonth(List<dynamic> jobs) {
  final Map<String, List<dynamic>> grouped = {};
  for (var job in jobs) {
    final date = DateTime.tryParse(job.applicationDate);
    if (date == null) continue;
    final monthKey = DateFormat('MMMM yyyy').format(date);
    if (!grouped.containsKey(monthKey)) {
      grouped[monthKey] = [];
    }
    grouped[monthKey]!.add(job);
  }
  return grouped;
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
