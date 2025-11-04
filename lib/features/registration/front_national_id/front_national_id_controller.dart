/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-29 2:15 PM
 ==================================================================
*/

import 'dart:io';

import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';

class FrontNationalIdController extends GetxController {
  final String tempToken;

  File? frontIdImage;

  // error message to show under the picker (nullable)
  var idError = RxnString(null);

  FrontNationalIdController({required this.tempToken});

  void setFrontIdImage(File? value) {
    frontIdImage = value;
  }

  /// Validate and navigate if file exists; otherwise show error text
  void validateAndContinue() {
    if (frontIdImage == null) {
      idError.value = "Please provide your front ID image to continue";
      return;
    }

    idError.value = null;
    // navigate to next screen
    Get.toNamed(
      "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}${Routes.createAccountFrontID}${Routes.createAccountBackID}",
    );
  }
}
