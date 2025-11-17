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

  /// Validate file before uploading
  void validateAndUpload() {
    if (cvFile == null) {
      cvFileError.value = "cv_required".tr;
      return;
    }
    cvFileError.value = null;
    uploadAllFiles();
  }

  /// Upload all required files and update profile
  Future<void> uploadAllFiles() async {
    try {
      Get.context!.loaderOverlay.show();

      final frontNationalIdController = Get.find<FrontNationalIdController>();
      final educationInfoController = Get.find<EducationInfoController>();
      final skillsController = Get.find<CreateAccountSkillsController>();
      final tempToken = "Bearer ${frontNationalIdController.tempToken}";

      final graduationYear = int.parse(
        educationInfoController.graduationYearController.text.trim(),
      );

      // Collect all files
      final files = [
        frontNationalIdController.frontIdImage!,
        Get.find<BackNationalIdController>().backIdImage!,
        Get.find<PictureWithIdController>().picWithIdImage!,
        Get.find<EducationPicController>().educationImage!,
        cvFile!
      ];

      // Convert to MultipartFile
      final multipartFiles = await Future.wait(files.map(_toMultipart));

      // Upload
      final uploadResponse = await apiClient.uploadFile(multipartFiles);

      if (uploadResponse.isSuccess) {
        final urls = uploadResponse.urls!;
        await _updateUserProfile(
          urls: urls,
          educationInfoController: educationInfoController,
          skillsController: skillsController,
          graduationYear: graduationYear,
          tempToken: tempToken,
        );
      } else {
        showSnackBarError(
          "upload_failed".tr,
          uploadResponse.details?.message ?? "upload_error".tr,
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }

  /// Convert File → MultipartFile
  Future<MultipartFile> _toMultipart(File file) async {
    final bytes = await file.readAsBytes();
    return MultipartFile.fromBytes(
      bytes,
      filename: file.path.split('/').last,
    );
  }

  /// Update user profile after uploading all files
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
          "profile_updated".tr,
          response.details.message ??
              "upload_success".tr,
        );
        Get.until((route) => Get.currentRoute == Routes.authChoice);
      } else {
        showSnackBarError(
          "update_failed".tr,
          response.details.message ?? "update_error".tr,
        );
      }
    } catch (e) {
      showSnackBarApiError();
    }
  }
}
