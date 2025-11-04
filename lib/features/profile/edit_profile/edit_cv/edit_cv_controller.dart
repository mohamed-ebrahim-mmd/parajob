import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/src/models/requests/documents.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import '../../../../packages/api_client/api_client.dart';

class EditCvController extends GetxController {
  final BuildContext screenContext;
  EditCvController({required this.screenContext});
  final profileController = Get.find<ProfileController>();
  final String token = Get.find<UserController>().token!;
  late final user = profileController.profileData;
  File? cvFile ;
 final selectedCvName= Rx<String?>(null);

 @override
  void onInit() {
    super.onInit();
selectedCvName.value = user?.cv != null
    ? user!.cv!.split('/').last
    : null;  }


  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      cvFile = File(result.files.single.path!);
      selectedCvName.value = cvFile!.path.split('/').last;
    }
  }

  Future<void> uploadFile() async {
    if (cvFile == null) {
      showSnackBarError("No files changed", "no files changed");
      return;
    }

    screenContext.loaderOverlay.show();
    try {
      final fileBytes = await cvFile!.readAsBytes();

      final multipartFile = MultipartFile.fromBytes(
        fileBytes,
        filename: selectedCvName.value,
      );

      final response = await apiClient.uploadFile([multipartFile]);

      if (response.isSuccess && response.urls != null) {
        var url = response.urls?[0];
              //  showSnackBarSuccess("title", url??"null url");

        if (url == null || url.isEmpty) {
          showSnackBarError("Failed", "No file URL returned from upload API");
          return;
        }

        await editUserProfile(url);
      } else {
        showSnackBarError(
          "Failed",
          response.details?.message ?? "Upload failed",
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      screenContext.loaderOverlay.hide();
    }
  }

  Future<void> editUserProfile(String url) async {
    screenContext.loaderOverlay.show();
    try {
      final response = await apiClient.updateUserProfile(
        EditUserRequest(documents: Documents(cv: url)),
        token,
      );

      if (response.isSuccess) {
        await profileController.fetchProfileDetails();
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
      showSnackBarApiError();
    } finally {
      screenContext.loaderOverlay.hide();
    }
  }
}
