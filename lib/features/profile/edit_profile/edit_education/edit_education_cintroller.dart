import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/src/models/requests/edit_user_request.dart';
import 'package:para_job/packages/api_client/src/service/api_client_instance.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class EditEducationController extends GetxController {
  final BuildContext screenContext;
  EditEducationController(this.screenContext);
  final facultyController = TextEditingController();
  final graduationYearController = TextEditingController();
    var olderUser = Get.find<ProfileController>().profileData;
      final String token = Get.find<UserController>().token!;


   @override
  void onInit() {
    super.onInit();
    setInitialData();
  }


  Future<void> editUserProfile(
   
  ) async {
    screenContext.loaderOverlay.show();
    try {
      final response = await apiClient.updateUserProfile(EditUserRequest(graduationYear:int.tryParse(graduationYearController.text),facultyId:1) , token);

      if (response.isSuccess) {
        log("🟢 isSuccess");
        showSnackBarSuccess(
          "success",
          response.details.message ?? "edit successfully",
        );
      } else {
        showSnackBarError("Failed", response.details.message ?? "edit failed");
        log(response.details.message ?? "edit failed");
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      showSnackBarError("Failed", e.toString());
    } finally {
       screenContext.loaderOverlay.hide();
    }
  }



  void onClose() {
    facultyController.dispose();
    graduationYearController.dispose();
    super.onClose();
  }
  
  void setInitialData() {
    facultyController.text = olderUser!.faculty??"";
    graduationYearController.text = olderUser!.graduationYear??"";
  }
}
