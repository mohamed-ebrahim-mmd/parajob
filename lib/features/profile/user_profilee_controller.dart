import 'dart:developer';

import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';

class ProfileController extends GetxController {
  var profileCallState = ApiCallState.loading.obs;
  UserProfileResponse? profileData;
  final String token;
  ProfileController(this.token);

  @override
  void onInit() {
    super.onInit();
    fetchProfileDetails(token);
  }

  Future<void> fetchProfileDetails(String token,) async {
    profileCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchUserProfile(token: token);

      if (response.isSuccess) {
        log("🟢 isSuccess");

        profileData = response;

        profileCallState.value = ApiCallState.success;
      } else {
        profileCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("🟢 ${e.toString()}");
      profileCallState.value = ApiCallState.failure;
    }
  }
}
