/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2024-12-24 4:15 PM
 ==================================================================
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class ContactUsController extends GetxController {
  final user = Get.find<UserController>().user!;
  final messageController = TextEditingController();
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

  Future<void> validateAndSubmit(BuildContext context) async {
    messageError.value = validateMessage(messageController.text);

    if (messageError.value == null) {
      await _contactUs(context);
    }
  }


  Future<void> _contactUs(BuildContext context) async {
    try {
      context.loaderOverlay.show();

      final response = await apiClient.contactUs(
        ContactUsRequest(
          name: user.name ?? "",
          email: user.email ?? "",
          message: messageController.text,
        ),
      );

      if (response.isSuccess) {
        showSnackBarSuccess(
          "success_title".tr,
          response.details.message ?? "message_sent_successfully".tr,
        );
      } else {
        showSnackBarError(
          "failed_title".tr,
          response.details.message ?? "message_sent_failed".tr,
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }




  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
