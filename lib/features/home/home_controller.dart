/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-16 9:51 AM
 ==================================================================
*/
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';

class HomeController extends GetxController {
  var homeCallState = ApiCallState.loading.obs;
  HomeResponse? homeData;

  @override
  void onInit() {
    super.onInit();
    fetchHomeJobs();
  }

  Future<void> fetchHomeJobs() async {
    homeCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchHomeJobs();

      if (response.isSuccess) {
        homeData = response;

        homeCallState.value = ApiCallState.success;
      } else {
        homeCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      homeCallState.value = ApiCallState.failure;
    }
  }
}
