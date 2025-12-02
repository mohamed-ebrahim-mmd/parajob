//Mary Mark ||  mary.mark@moselaymd.com || Tue Dec 02 2025 17:10:28

/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-24 4:15 PM
 ==================================================================
*/

import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class InterviewController extends GetxController {
  final user = Get.find<UserController>().user!;
  ContactInfoData? contactInfo;
  var interviewCallState = ApiCallState.loading.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInterviewData();
  }

  Future<void> fetchInterviewData() async {
    interviewCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.getContactInfo();

      if (response.isSuccess) {
        contactInfo = response.data;

        interviewCallState.value = ApiCallState.success;
      } else {
        interviewCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      interviewCallState.value = ApiCallState.failure;
    }
  }
}
