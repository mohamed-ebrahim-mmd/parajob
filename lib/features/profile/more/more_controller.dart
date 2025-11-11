import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class MoreController extends GetxController {
  //var moreCallState = ApiCallState.loading.obs;
  //  UserProfileData? profileData;
  final user = Get.find<UserController>();
  MoreController();

  Future<void> deleteUserAccount(BuildContext context) async {
    Navigator.of(context).pop();
    context.loaderOverlay.show();
    try {
      final response = await apiClient.deleteAccount(token: user.token!);

      if (response.isSuccess) {
        log("🟢 isSuccess");
        showSnackBarSuccess(
          "Success",
          response.details.message ?? "your account deleted successfully",
        );

        Get.find<RoutingController>().logOut();
      } else {
        showSnackBarError(
          "Failed",
          response.details.message ?? "your account deleted failed",
        );
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      showSnackBarError("Failed", e.toString());
    } finally {
      context.loaderOverlay.hide();
    }
  }

  // Send the forgot password request to API
  Future<void> sendChangePassRequest(BuildContext context) async {
    try {
      context.loaderOverlay.show();

      final response = await apiClient.sendOtp(
        SendOtpRequest(phoneNumber: user.user!.phoneNumber ?? "-"),
      );

      if (response.isSuccess ?? false) {
        showSnackBarSuccess('Success', response.details?.message ?? '');
        //go to the otp screen
        Get.toNamed(
          "${Routes.mainNavigator}${Routes.more}${Routes.changePassOtp}",
        );
      } else {
        showSnackBarError(
          'Failed',
          response.details?.message ?? 'Unknown error',
        );
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }
}
