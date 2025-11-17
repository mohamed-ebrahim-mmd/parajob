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
  final user = Get.find<UserController>();

  MoreController();

  void navigateTo(String route) {
    Get.toNamed("${Routes.mainNavigator}${Routes.more}$route");
  }

  Future<void> deleteUserAccount(BuildContext context) async {
    Navigator.of(context).pop();
    context.loaderOverlay.show();
    try {
      final response = await apiClient.deleteAccount(token: user.token!);

      if (response.isSuccess) {
        log("🟢 isSuccess");
        showSnackBarSuccess(
          "success_title".tr,
          response.details.message ?? "account_deleted_successfully".tr,
        );

        Get.find<RoutingController>().logOut();
      } else {
        showSnackBarError(
          "failed_title".tr,
          response.details.message ?? "account_deleted_failed".tr,
        );
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      showSnackBarApiError();
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
        showSnackBarSuccess(
          'success_title'.tr,
          response.details?.message ?? "otp_sent".tr,
        );
        //go to the otp screen
        Get.toNamed(
          "${Routes.mainNavigator}${Routes.more}${Routes.changePassOtp}",
        );
      } else {
        showSnackBarError(
          'failed_title'.tr,
          response.details?.message ?? 'unknown_error'.tr,
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
