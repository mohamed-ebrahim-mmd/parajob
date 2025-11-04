import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/src/models/requests/documents.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import '../../../../packages/api_client/api_client.dart';

class EditNationalIdController extends GetxController {
  final BuildContext screenContext;
  EditNationalIdController({required this.screenContext});
  final profileController = Get.find<ProfileController>();
  final String token = Get.find<UserController>().token!;
  late final user = profileController.profileData;
  final ImagePicker picker = ImagePicker();
  var frontFile = Rx<File?>(null);
  var backFile = Rx<File?>(null);
  var profileFile = Rx<File?>(null);

  Future<void> pickImg(Rx<File?> target) async {
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      target.value = File(picked.path);
    }
  }

  // Future<void> uploadFile() async {
  //   final List<File> filesList = [
  //     frontFile.value,
  //     backFile.value,
  //     profileFile.value,
  //   ].whereType<File>().toList();

  //   if (filesList.isEmpty) {
  //     showSnackBarError("No files changed", "no files changed");
  //     return;
  //   }

  //   screenContext.loaderOverlay.show();
  //   try {
  //     // Convert files to MultipartFile list
  //     final multipartFiles = await Future.wait(
  //       filesList.map((file) async {
  //         final bytes = await file.readAsBytes();
  //         return MultipartFile.fromBytes(
  //           bytes,
  //           filename: file.path.split('/').last,
  //         );
  //       }),
  //     );

  //     final response = await apiClient.uploadFile(multipartFiles);

  //     if (response.isSuccess) {
  //       var url = response.urls;
  //       // await updateUserPic(context, url ?? "");
  //     } else {
  //       showSnackBarError(
  //         "Failed",
  //         response.details?.message ?? "your photo uploaded failed",
  //       );
  //     }
  //   } catch (e) {
  //     showSnackBarError("Failed", e.toString());
  //   } finally {
  //     screenContext.loaderOverlay.hide();
  //   }
  // }






Future<void> uploadFile() async {
  final Map<String, File?> fileMap = {
    "front": frontFile.value,
    "back": backFile.value,
    "profile": profileFile.value,
  };

  // Filter out null files but preserve the key
  final validFiles = fileMap.entries.where((e) => e.value != null).toList();

  if (validFiles.isEmpty) {
    showSnackBarError("No files changed", "no files changed");
    return;
  }

  screenContext.loaderOverlay.show();
  try {
    // Convert files to MultipartFile list
    final multipartFiles = await Future.wait(
      validFiles.map((entry) async {
        final file = entry.value!;
        final bytes = await file.readAsBytes();
        return MultipartFile.fromBytes(
          bytes,
          filename: file.path.split('/').last,
        );
      }),
    );

    final response = await apiClient.uploadFile(multipartFiles);

    if (response.isSuccess && response.urls != null) {
      final urls = response.urls!;
      // Map returned URLs to file types based on send order
      final Map<String, String> urlMap = {};
      for (int i = 0; i < validFiles.length; i++) {
        urlMap[validFiles[i].key] = urls[i];
      }

      await editUserProfile(urlMap);
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







  Future<void> editUserProfile(Map<String, String> urls) async {
    screenContext.loaderOverlay.show();
    try {
      final response = await apiClient.updateUserProfile(
        EditUserRequest(
        documents: Documents(
          nationalIdFront: urls["front"]??null,
          nationalIdBack: urls["back"]??null,
          profilePictureWithId: urls["profile"]??null,
        ),
      ),
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
