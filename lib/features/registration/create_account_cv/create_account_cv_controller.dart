/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-29 2:15 PM
 ==================================================================
*/

import 'dart:io';

import 'package:get/get.dart' hide MultipartFile;
import 'package:para_job/features/registration/back_national_id/back_national_id_controller.dart';
import 'package:para_job/features/registration/create_account_skills/create_account_skills_controller.dart';
import 'package:para_job/features/registration/education_info/education_info_controller.dart';
import 'package:para_job/features/registration/education_pic/education_pic_controller.dart';
import 'package:para_job/features/registration/front_national_id/front_national_id_controller.dart';
import 'package:para_job/features/registration/picture_with_id/picture_withl_id_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/api_client/src/models/requests/documents.dart';
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
      final frontNationalIdController = Get.find<FrontNationalIdController>();
      final educationInfoController = Get.find<EducationInfoController>();
      final createAccountSkillsController =
          Get.find<CreateAccountSkillsController>();
      final graduationYearText = int.parse(
        educationInfoController.graduationYearController.text.trim(),
      );
      educationInfoController.graduationYearController.text.trim();
      final tempToken = "Bearer ${frontNationalIdController.tempToken}";

      // --- Collect files from controllers ---
      final frontFile = frontNationalIdController.frontIdImage!;
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
      final filesResponse = await apiClient.uploadFile(files);

      if (filesResponse.isSuccess) {
        final urlResponseList = filesResponse.urls!;
        final response = await apiClient.updateUserProfile(
          EditUserRequest(
            universityId: educationInfoController.selectedUniversityId.value,
            facultyId: educationInfoController.selectedFacultyId,
            graduationYear: graduationYearText,
            skills: createAccountSkillsController.selectedSkillIds,
            documents: Documents(
              nationalIdFront: urlResponseList[0],
              nationalIdBack: urlResponseList[1],
              profilePictureWithId: urlResponseList[2],
              universityId: urlResponseList[3],
              cv: urlResponseList[4],
            ),
          ),
          tempToken,
        );
      } else {
        showSnackBarError(
          "Upload failed",
          filesResponse.details?.message ?? "Failed to upload files.",
        );
      }
    } catch (e) {
      showSnackBarApiError();
    }
  }
}
