import 'dart:developer';

import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';

class JobDetailsController extends GetxController {
  var jobDetailsCallState = ApiCallState.loading.obs;
  JobDetailsResponse? jobData;
  final int jobId;

  JobDetailsController(this.jobId);

  @override
  void onInit() {
    super.onInit();
    fetchJobDetails(jobId);
  }

  Future<void> fetchJobDetails(int id) async {
    jobDetailsCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchJobDetails(id);

      if (response.isSuccess) {
        log("🟢 isSuccess");

        jobData = response;

        jobDetailsCallState.value = ApiCallState.success;
      } else {
        jobDetailsCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("🟢 ${e.toString()}");
      jobDetailsCallState.value = ApiCallState.failure;
    }
  }
}
