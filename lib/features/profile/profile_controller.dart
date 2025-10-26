import 'dart:developer';

import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class ProfileController extends GetxController {
  var profileCallState = ApiCallState.loading.obs;
  UserProfileData? profileData;
  final String token = Get.find<UserController>().token!;
  ProfileController();

  @override
  void onInit() {
    super.onInit();
    fetchProfileDetails();
  }

  Future<void> fetchProfileDetails() async {
    profileCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchUserProfile(token: token);

      if (response.isSuccess) {
        log("🟢 isSuccess");

        profileData = response.data;

        profileCallState.value = ApiCallState.success;
      } else {
        profileCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      profileCallState.value = ApiCallState.failure;
    }
  }
}
