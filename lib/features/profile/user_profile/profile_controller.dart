import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/home/home_controller.dart';
import 'package:para_job/features/main_navigator/main_navigator_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/img_picker.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class ProfileController extends GetxController {
  final _homeController = Get.find<HomeController>();
  var profileCallState = ApiCallState.loading.obs;
  UserProfileData? profileData;
  final user = Get.find<UserController>();
  final navController = Get.find<MainNavigatorController>();

  ProfileController();

  @override
  void onInit() {
    super.onInit();
    fetchProfileDetails();
  }

  void onSeeAllSavedJobs() {
    Get.toNamed("${Routes.mainNavigator}${Routes.bookmarkedJobs}");
  }

  void onSeeAllHistoryJobs() {
    Get.toNamed("${Routes.mainNavigator}${Routes.historyJobs}");
  }

  Future<void> deleteUserPic(BuildContext context) async {
    Get.back();

    context.loaderOverlay.show();
    //var m =await  Future.delayed(const Duration(seconds: 3));
    try {
      final response = await apiClient.deleteUserPhoto(token: user.token!);

      if (response.isSuccess) {
        log("🟢 deleteUserPic isSuccess");

        fetchProfileDetails();
        navController.deleteUserProfilePic();
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

  Future<void> uploadFile(BuildContext context) async {
    var file = await pickImageFile();

    // if no file is selected return
    if (file == null) return;

    Get.back();

    context.loaderOverlay.show();
    try {
      final fileBytes = await file.readAsBytes();

      final multipartFile = MultipartFile.fromBytes(
        fileBytes,
        filename: file.path.split('/').last,
      );

      final response = await apiClient.uploadFile([multipartFile]);

      if (response.isSuccess) {
        var url = response.urls?[0];
        if (url == null || url.isEmpty) {
          showSnackBarError("Failed", "No file URL returned from upload API");
          return;
        }

        await updateUserPic(context, url);
      } else {
        showSnackBarError(
          "Failed",
          response.details?.message ?? "your photo uploaded failed",
        );
      }
    } catch (e) {
      showSnackBarError("Failed", e.toString());
    } finally {
      context.loaderOverlay.hide();
    }
  }

  Future<void> updateUserPic(BuildContext context, String url) async {
    try {
      final response = await apiClient.updateUserPhoto(
        UpdateUserPhotoRequest(profilePicture: url),
        user.token!,
      );

      if (response.isSuccess) {
        fetchProfileDetails();
        navController.setUserProfilePic(url);
      } else {
        showSnackBarError(
          "Failed",
          response.details.message ?? "your photo deleted failed",
        );
      }
    } catch (e) {
      showSnackBarError("Failed", e.toString());
    }
  }

  Future<void> fetchProfileDetails() async {
    profileCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchUserProfile(token: user.token!);

      if (response.isSuccess) {
        log("🟢 fetchProfileDetails isSuccess");

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

  Future<void> removeBookmark(int jobId, BuildContext context) async {
    try {
      context.loaderOverlay.show();
      final response = await apiClient.deleteBookmark(
        BookmarkRequest(jobId: jobId),
        user.token!,
      );

      if (response.isSuccess) {
        fetchProfileDetails();
        if (_homeController.jobIsInHome(jobId)) {
          _homeController.fetchHomeJobs();
        }
        showSnackBarSuccess(
          "Success",
          response.details?.message ?? "Job removed from bookmarks.",
        );
      } else {
        log("🔴 removeBookmark ${response.details!.message}");
        showSnackBarError(
          "Failed",
          response.details?.message ?? "Could not remove bookmark.",
        );
      }
    } catch (e) {
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }

  bool jobIsInSavedJobs(int id) {
    final savedJobs = profileData?.savedJobs ?? [];
    return savedJobs.any((job) => job.id == id);
  }
}
