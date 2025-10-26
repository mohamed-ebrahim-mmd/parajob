import 'dart:developer';

import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class ProfileController extends GetxController {
  var profileCallState = ApiCallState.loading.obs;
  UserProfileResponse? profileData;
  final String token=
  //"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjQ0OWY1N2VmMjVkZjc2MmJjNWQ5Njk1NWEwNTFhMThmNjQ4ZTA0NjcwZmMzMjg5ZDdlNTdkNmI1YjViZjM3NzU3NTdhMWRjOTM2NjE3OWMiLCJpYXQiOjE3NjEyMjY1NjEuMDg3MjEzLCJuYmYiOjE3NjEyMjY1NjEuMDg3MjE2LCJleHAiOjE3OTI3NjI1NTkuNzAzMTA4LCJzdWIiOiIxIiwic2NvcGVzIjpbInVzZXIiXX0.eZmh8RJbV6WdeXhtDQyfUblFhT_FS_lm2ijer2Yk7XzlGG1_j8A2zDllE8LZ0l_jD1OG3jTbZsZYkp4vtDSbx2kEuuhZGG2dC5guiKQG_hy5L1WRdhRyclNdPnNer1JbF21XRIuBMxNhFKH0wISOxC_6mIgPLeynefRAN6nH1QZT5YOjSFY7BxVlmYYR5PxJTMnr9pKh_WaDKLgjVgyX6taXR1G6-nwMjwJNWNLo6tVjzkWx2LJyPVvvhu7AnasyrnLlLwghCzoCfsgmOq_gGmIZdOWtVcor4SXaTHVp05z5Lzvu-drz5omNbW5VBKfzd_X2BNu_bT53vqEPh6ghlrfcrCbOPcHvgdAOLBMTiSfPJmAoJisQXX4f7RnEaay5iVw5YQ3wkIo913ZjX22q7w3A38HRQGBy-For8UdgB47JFcJFy8QMonHYFFOS4XnEwbyzSEVZzlbPsw19jYyVeE5sfLpAXwAMjqNWaBdWh38y_NHPm2c8MWatX8d2rlDpR9TapVcSMYnEw-08hHKSc1Aq4FG5fQ4Xrb5POF1UU62Dkzofu-2GAMqzlhxbahDkzN0J5vZxwnlAzONBDEbPM14SMXiZlfkURXinNe2PtN9sCvGmrf3cfnnP7zbm6oZn8hWnmDqjqnXzgosxM71eo0NwMwkCjdo_jcXcmKmtQiE";
  Get.find<UserController>().token!;
  ProfileController();

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
