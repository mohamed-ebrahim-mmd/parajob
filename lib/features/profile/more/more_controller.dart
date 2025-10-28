import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';


class MoreController extends GetxController {
  //var moreCallState = ApiCallState.loading.obs;
//  UserProfileData? profileData;
  final String token = Get.find<UserController>().token!;
  MoreController();




  Future<void> deleteUserAccount(BuildContext context) async {
  
    context.loaderOverlay.show();

    try {
     

   final response = await apiClient.deleteAccount(token: token);

      if (response.isSuccess) {
        log("🟢 isSuccess");
         showSnackBarSuccess(
          "Success", "your account deleted successfully"
        );
 
         Get.find<RoutingController>().logOut();


      } else {
        showSnackBarError(
          "Failed", "your account deleted failed"
        );
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
       showSnackBarSuccess(
          "Failed", "your account deleted failed"
        );
    }finally {
      context.loaderOverlay.hide();
    }
  }


}
