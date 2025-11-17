/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-29 2:15 PM
 ==================================================================
*/

import 'dart:io';

import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';

class BackNationalIdController extends GetxController {
  File? backIdImage;

  // Error message to show under the picker (nullable)
  var idError = RxnString(null);

  void setBackIdImage(File? value) {
    backIdImage = value;
  }

  /// Validate and navigate if file exists; otherwise show error text
  void validateAndContinue() {
    if (backIdImage == null) {
      idError.value = "back_id_required".tr;
      return;
    }

    idError.value = null;
    // Navigate to next screen
    Get.toNamed(
      "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}${Routes.createAccountFrontID}${Routes.createAccountBackID}${Routes.createAccountPicWithID}",
    );
  }
}
