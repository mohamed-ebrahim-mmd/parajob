import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

import '../../packages/api_client/src/models/requests/submit_review_request.dart';
import '../../packages/ui_components/auth_required_dialog.dart';
import '../../packages/user_manager/user_controller.dart';

class EmployerController extends GetxController {
  final int companyId;
  final user = Get.find<UserController>();

  EmployerController(this.companyId);

  var companyCallState = ApiCallState.loading.obs;
  Company? companyData;

  final reviewController = TextEditingController();
  var selectedRating = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompany();
  }

  Future<void> fetchCompany() async {
    companyCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchCompany(
        id: companyId,
        token: user.isGuest
            ? null
            : user.token,
      );

      if (response.isSuccess == true) {
        companyData = response.data;
        print("Company data: ${companyData.toString()}");
        companyCallState.value = ApiCallState.success;
      } else {
        companyCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("Error fetching employer: ${e.toString()}");
      companyCallState.value = ApiCallState.failure;
    }
  }

  Future<void> submitReview() async {
    if (user.token == null) {
      showAuthRequiredDialog();
    } else {
      final reviewText = reviewController.text.trim();
      final rating = selectedRating.value;

      if (rating == 0 || reviewText.isEmpty) {
        showSnackBarError(
          "Warning",
          "Please select a rating and write a comment.",
        );
        return;
      }

      final request = SubmitReviewRequest(
        review: reviewText,
        rate: rating,
        companyId: companyId,
        isAnonymous: true,
      );
      print("sss => $request");

      try {
        Get.context!.loaderOverlay.show();

        final response = await apiClient.submitReview(
          token: user.token!,
          request: request,
        );

        if (response.isSuccess == true) {
          showSnackBarSuccess("Success", "Review submitted successfully!");
          reviewController.clear();
          selectedRating.value = 0;
          fetchCompany();
        } else {
          showSnackBarError(
            "Failed",
            "${response.details?.message ?? "Unknown error"}",
          );
        }
      } catch (e) {
        log("Error submitting review: $e");
        showSnackBarApiError();
      } finally {
        Get.context!.loaderOverlay.hide();
      }
    }
  }

  @override
  void onClose() {
    reviewController.dispose();
    super.onClose();
  }
}
