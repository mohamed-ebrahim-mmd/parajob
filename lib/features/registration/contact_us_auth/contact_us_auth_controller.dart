//Mary Mark ||  mary.mark@moselaymd.com || Sun Nov 23 2025 15:02:59

/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-24 4:15 PM
 ==================================================================
*/

import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';

class ContactUsAuthController extends GetxController {
  var messageError = RxnString(null);
  ContactInfoData? contactInfo;
  var contactCallState = ApiCallState.loading.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContactInfo();
  }

  Future<void> fetchContactInfo() async {
    contactCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.getContactInfo();

      if (response.isSuccess) {
        contactInfo = response.data;

        contactCallState.value = ApiCallState.success;
      } else {
        contactCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      contactCallState.value = ApiCallState.failure;
    }
  }
}
