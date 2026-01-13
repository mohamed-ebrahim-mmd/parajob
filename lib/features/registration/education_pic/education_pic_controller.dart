/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-29 2:15 PM
 ==================================================================
*/

import 'dart:io';
import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';

class EducationPicController extends GetxController {
  Rx<File?> educationImage = Rx<File?>(null);

  // error message to show under the picker (nullable)
  var educationImgError = RxnString(null);

  void setEducationImage(File? value) {
    educationImage.value = value;
  }

  /// Validate and navigate if file exists; otherwise show error text
  void validateAndContinue() {
    if (educationImage.value == null) {
      educationImgError.value = 'education_image_required'.tr;
      return;
    }

    educationImgError.value = null;

    // navigate to next screen
    Get.toNamed(
      "${Routes.createAccount}"
      "${Routes.createAccountOTP}"
      "${Routes.createAccountSetPass}"
      "${Routes.createAccountFrontID}"
      "${Routes.createAccountBackID}"
      "${Routes.createAccountPicWithID}"
      "${Routes.educationInfo}"
      "${Routes.educationPic}${Routes.createAccountSkills}",
    );
  }

  bool get isEducationImageValid => educationImage.value != null;
}
