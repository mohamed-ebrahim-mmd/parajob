import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/src/models/requests/documents.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import '../../../../packages/api_client/api_client.dart';

class EditCvController extends GetxController {
  final BuildContext screenContext;
  EditCvController({required this.screenContext});
  final profileController = Get.find<ProfileController>();
  final String token = Get.find<UserController>().token!;
  late final user = profileController.profileData;
  File? cvFile;
  final selectedCvName = Rx<String?>(null);
  String? selectedCvPath;

  @override
  void onInit() {
    super.onInit();
    selectedCvPath = user?.cv;
    selectedCvName.value = user?.cv != null ? user!.cv!.split('/').last : null;
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      cvFile = File(result.files.single.path!);
      selectedCvName.value = cvFile!.path.split('/').last;
      selectedCvPath = cvFile!.path;
    }
  }

  void onShowPdf() {
    Get.toNamed(
      "${Routes.mainNavigator}${Routes.more}${Routes.editProfile}${Routes.pdfViewer}",
    );
  }

  Future<void> uploadFile() async {
    if (cvFile == null) {
      showSnackBarError("nothing_to_update".tr, "no_changes_made".tr);
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

        if (url == null || url.isEmpty) {
          showSnackBarError("failed_title".tr, "no_file_url_returned".tr);
          return;
        }

        await editUserProfile(url);
      } else {
        showSnackBarError(
          "failed_title".tr,
          response.details?.message ?? "upload_failed".tr,
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
          "success_title".tr,
          response.details.message ?? "edit_successfully".tr,
        );
      } else {
        showSnackBarError(
          "failed_title".tr,
          response.details.message ?? "edit_failed".tr,
        );
        log(response.details.message ?? "edit_failed");
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      screenContext.loaderOverlay.hide();
    }
  }
}
