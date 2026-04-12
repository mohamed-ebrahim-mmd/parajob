import 'dart:developer';

import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';

class AboutAppController extends GetxController {
  var aboutUsCallState = ApiCallState.loading.obs;
  AboutUsData? aboutUsData;

  AboutAppController();

  @override
  void onInit() {
    super.onInit();
    fetchAboutUsDetails();
  }

  Future<void> fetchAboutUsDetails() async {
    aboutUsCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.getAboutUs();

      if (response.isSuccess) {
        log("🟢 isSuccess");

        aboutUsData = response.data;

        aboutUsCallState.value = ApiCallState.success;
      } else {
        aboutUsCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      aboutUsCallState.value = ApiCallState.failure;
    }
  }
}
