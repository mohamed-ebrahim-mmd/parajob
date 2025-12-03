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
  var interviewCallState = ApiCallState.loading.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInterviewData();
  }

  Future<void> fetchInterviewData() async {
    interviewCallState.value = ApiCallState.loading;

    try {
      //final response = await apiClient.getContactInfo();
       await Future.delayed(const Duration(seconds: 7));
      if (true) {

        interviewCallState.value = ApiCallState.success;
      } else {
        interviewCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      interviewCallState.value = ApiCallState.failure;
    }
  }

  // Future<void> sendInterviewStatus(BuildContext context,String status) async {
  //   try {
  //     context.loaderOverlay.show();
  //     Future.delayed(const Duration(seconds: 2));

  //     if (true) {
  //       showSnackBarSuccess(
  //         "success_title".tr,"interview_status_sent_successfully".tr,
  //        // response.details.message ?? "interview_status_sent_successfully".tr,
  //       );
  //     } else {
  //       showSnackBarError(
  //         "failed_title".tr,"failed_to_send_interview_status".tr,
  //       //  response.details.message ?? "failed_to_send_interview_status".tr,
  //       );
  //     }
  //   } catch (e) {
  //     showSnackBarApiError();
  //   } finally {
  //     context.loaderOverlay.hide();
  //   }
  // }
}
