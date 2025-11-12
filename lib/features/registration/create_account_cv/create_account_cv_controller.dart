/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-29 2:15 PM
 ==================================================================
*/

import 'dart:io';

import 'package:get/get.dart' hide MultipartFile;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/registration/back_national_id/back_national_id_controller.dart';
import 'package:para_job/features/registration/create_account_skills/create_account_skills_controller.dart';
import 'package:para_job/features/registration/education_info/education_info_controller.dart';
import 'package:para_job/features/registration/education_pic/education_pic_controller.dart';
import 'package:para_job/features/registration/front_national_id/front_national_id_controller.dart';
import 'package:para_job/features/registration/picture_with_id/picture_withl_id_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/api_client/src/models/requests/documents.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart'
    show Routes;
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
    uploadAllFiles();
  }

  Future<void> uploadAllFiles() async {
    try {
      Get.context!.loaderOverlay.show();
      final frontNationalIdController = Get.find<FrontNationalIdController>();
      final educationInfoController = Get.find<EducationInfoController>();
      final createAccountSkillsController =
          Get.find<CreateAccountSkillsController>();
      final tempToken = "Bearer ${frontNationalIdController.tempToken}";

      final graduationYearText = int.parse(
        educationInfoController.graduationYearController.text.trim(),
      );

      // --- Collect files from controllers ---
      final frontFile = frontNationalIdController.frontIdImage!;
      final backFile = Get.find<BackNationalIdController>().backIdImage!;
      final idWithPicFile = Get.find<PictureWithIdController>().picWithIdImage!;
      final graduationFile = Get.find<EducationPicController>().educationImage!;
      final cvFileLocal = cvFile!;

      // --- Convert each to MultipartFile ---
      final files = await Future.wait([
        _toMultipart(frontFile),
        _toMultipart(backFile),
        _toMultipart(idWithPicFile),
        _toMultipart(graduationFile),
        _toMultipart(cvFileLocal),
      ]);

      // --- Upload all at once ---
      final filesResponse = await apiClient.uploadFile(files);

      if (filesResponse.isSuccess) {
        final urls = filesResponse.urls!;
        await _updateUserProfile(
          urls: urls,
          educationInfoController: educationInfoController,
          skillsController: createAccountSkillsController,
          graduationYear: graduationYearText,
          tempToken: tempToken,
        );
      } else {
        showSnackBarError(
          "Upload failed",
          filesResponse.details?.message ?? "Failed to upload files.",
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }

  /// Helper to convert File → MultipartFile
  Future<MultipartFile> _toMultipart(File file) async {
    final bytes = await file.readAsBytes();
    return MultipartFile.fromBytes(bytes, filename: file.path.split('/').last);
  }

  /// Separate method to handle profile update logic
  Future<void> _updateUserProfile({
    required List<String> urls,
    required EducationInfoController educationInfoController,
    required CreateAccountSkillsController skillsController,
    required int graduationYear,
    required String tempToken,
  }) async {
    try {
      final response = await apiClient.updateUserProfile(
        EditUserRequest(
          universityId: educationInfoController.selectedUniversityId.value,
          facultyId: educationInfoController.selectedFacultyId,
          graduationYear: graduationYear,
          skills: skillsController.selectedSkillIds,
          documents: Documents(
            nationalIdFront: urls[0],
            nationalIdBack: urls[1],
            profilePictureWithId: urls[2],
            universityId: urls[3],
            cv: urls[4],
          ),
          educationStatus: educationInfoController.selectedStatus,
        ),
        tempToken,
      );

      if (response.isSuccess) {
        showSnackBarSuccess(
          "Profile Updated",
          response.details.message ??
              "Your files and info were uploaded successfully!",
        );
        Get.until((route) => Get.currentRoute == Routes.authChoice);
      } else {
        showSnackBarError(
          "Update failed",
          response.details.message ?? "Failed to update your profile.",
        );
      }
    } catch (e) {
      showSnackBarApiError();
    }
  }
}
