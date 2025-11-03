/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-29 2:15 PM
 ==================================================================
*/

import 'dart:io';

import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';

class PictureWithIdController extends GetxController {
  File? picWithIdImage;
  // error message to show under the picker (nullable)
  var idError = RxnString(null);

  void sePictureWithIdImage(File? value) {
    picWithIdImage = value;
  }

  /// Validate and navigate if file exists; otherwise show error text
  void validateAndContinue() {
    if (picWithIdImage == null) {
      idError.value = "Please provide a picture of yourself holding the ID to continue";
      return;
    }

    idError.value = null;
    // navigate to next screen
    Get.toNamed(
      "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}${Routes.createAccountFrontID}${Routes.createAccountBackID}${Routes.createAccountPicWithID}${Routes.educationInfo}",
    );
  }
}
