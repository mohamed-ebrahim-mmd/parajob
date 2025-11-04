/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-29 2:15 PM
 ==================================================================
*/

import 'dart:io';

import 'package:get/get.dart' hide MultipartFile;
import 'package:para_job/features/registration/back_national_id/back_national_id_controller.dart';
import 'package:para_job/features/registration/education_pic/education_pic_controller.dart';
import 'package:para_job/features/registration/front_national_id/front_national_id_controller.dart';
import 'package:para_job/features/registration/picture_with_id/picture_withl_id_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

class CreateAccountCvController extends GetxController {
  File? cvFile;

  // error message to show under the picker (nullable)
  var cvFileError = RxnString(null);

  void setCvFile(File? value) {
    cvFile = value;
  }

  void validateAndUpload() {
    if (cvFile == null) {
      cvFileError.value = "Please provide your CV to Confirm";
      return;
    }
    cvFileError.value = null;
  }

  Future<void> uploadAllFiles() async {
    try {
      // --- Collect files from controllers ---
      final frontFile = Get.find<FrontNationalIdController>().frontIdImage!;
      final backFile = Get.find<BackNationalIdController>().backIdImage!;
      final idWithPicFile = Get.find<PictureWithIdController>().picWithIdImage!;
      final graduationFile = Get.find<EducationPicController>().educationImage!;

      // --- Convert each to MultipartFile ---
      final frontBytes = await frontFile.readAsBytes();
      final backBytes = await backFile.readAsBytes();
      final idWithPicBytes = await idWithPicFile.readAsBytes();
      final graduationBytes = await graduationFile.readAsBytes();
      final cvBytes = await cvFile!.readAsBytes();

      final files = [
        MultipartFile.fromBytes(
          frontBytes,
          filename: frontFile.path.split('/').last,
        ),
        MultipartFile.fromBytes(
          backBytes,
          filename: backFile.path.split('/').last,
        ),
        MultipartFile.fromBytes(
          idWithPicBytes,
          filename: idWithPicFile.path.split('/').last,
        ),
        MultipartFile.fromBytes(
          graduationBytes,
          filename: graduationFile.path.split('/').last,
        ),
        MultipartFile.fromBytes(
          cvBytes,
          filename: cvFile!.path.split('/').last,
        ),
      ];

      // --- Upload all at once ---
      final response = await apiClient.uploadFile(files);

      if (response.isSuccess) {
      } else {
        showSnackBarError(
          "Upload failed",
          response.details?.message ?? "Failed to upload files.",
        );
      }
    } catch (e) {
      showSnackBarApiError();
    }
  }
}
