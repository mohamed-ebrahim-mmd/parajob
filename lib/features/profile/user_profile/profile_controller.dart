import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';
import 'package:dio/dio.dart';

class ProfileController extends GetxController {
  var profileCallState = ApiCallState.loading.obs;
  UserProfileData? profileData;
  final String token = Get.find<UserController>().token!;
  ProfileController();

  @override
  void onInit() {
    super.onInit();
    fetchProfileDetails();
  }

  Future<void> deleteUserPic(BuildContext context) async {
    Get.back();

    context.loaderOverlay.show();
    //var m =await  Future.delayed(const Duration(seconds: 3));
    try {
      final response = await apiClient.deleteUserPhoto(token: token);

      if (response.isSuccess) {
        log("🟢 isSuccess");

        fetchProfileDetails();
      } else {
        showSnackBarError(
          "Failed",
          response.details.message ?? "your photo deleted failed",
        );
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      showSnackBarError("Failed", e.toString());
    } finally {
      context.loaderOverlay.hide();
    }
  }

  Future<void> uploadFile(BuildContext context, File file) async {
    Get.back();

    context.loaderOverlay.show();
    try {
      final fileBytes = await file.readAsBytes();

      final multipartFile = MultipartFile.fromBytes(
        fileBytes,
        filename: file.path.split('/').last,
      );

      final response = await apiClient.uploadFiles([multipartFile], token);

      if (response.isSuccess) {
        var url = response.data?[0];
        updateUserPic(context, url ?? "");
        log(url ?? "nooo");
      } else {
        showSnackBarError(
          "Failed",
          response.details.message ?? "your photo uploaded failed",
        );
      }
    } catch (e) {
      showSnackBarError("Failed", e.toString());
    }
  }

  Future<void> updateUserPic(BuildContext context, String url) async {
    try {
      final response = await apiClient.updateUserPhoto(
        UpdateUserPhotoRequest(profilePicture: url),
        token,
      );

      if (response.isSuccess) {
        fetchProfileDetails();
      } else {
        showSnackBarError(
          "Failed",
          response.details.message ?? "your photo deleted failed",
        );
      }
    } catch (e) {
      showSnackBarError("Failed", e.toString());
    } finally {
      context.loaderOverlay.hide();
    }
  }

  Future<void> fetchProfileDetails() async {
    profileCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchUserProfile(token: token);

      if (response.isSuccess) {
        log("🟢 isSuccess");

        profileData = response.data;

        profileCallState.value = ApiCallState.success;
      } else {
        profileCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      profileCallState.value = ApiCallState.failure;
    }
  }

  String formatNumber(num number) {
    if (number >= 1000000000) {
      return "${_trimZeros((number / 1000000000).toStringAsFixed(1))}B";
    } else if (number >= 1000000) {
      return "${_trimZeros((number / 1000000).toStringAsFixed(1))}M";
    } else if (number >= 1000) {
      return "${_trimZeros((number / 1000).toStringAsFixed(1))}K";
    } else {
      return _trimZeros(number.toStringAsFixed(0));
    }
  }

  String _trimZeros(String value) {
    // Removes ".0" at the end
    if (value.endsWith('.0')) {
      return value.substring(0, value.length - 2);
    }
    return value;
  }
}
