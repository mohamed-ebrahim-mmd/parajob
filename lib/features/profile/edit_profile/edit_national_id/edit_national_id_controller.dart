import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/functional_components/img_picker.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

import '../../../../packages/api_client/api_client.dart';

class EditNationalIdController extends GetxController {
  final BuildContext screenContext;

  EditNationalIdController({required this.screenContext});

  final profileController = Get.find<ProfileController>();

  Future<void> pickImg() async {
    var file = await pickImageFile();
    if (file != null) {
      // uploadFile(screenContext,file);
    }
  }

  Future<void> uploadFile(BuildContext context, File file) async {
    try {
      final fileBytes = await file.readAsBytes();

      final multipartFile = MultipartFile.fromBytes(
        fileBytes,
        filename: file.path.split('/').last,
      );

      final response = await apiClient.uploadFile([multipartFile]);

      if (response.isSuccess) {
        var url = response.urls?.first ?? "-";
        // await updateUserPic(context, url ?? "");
      } else {
        showSnackBarError(
          "Failed",
          response.details?.message ?? "your photo uploaded failed",
        );
      }
    } catch (e) {
      showSnackBarError("Failed", e.toString());
    } finally {
      context.loaderOverlay.hide();
    }
  }
}
