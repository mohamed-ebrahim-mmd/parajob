import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/ui_components/auth_required_dialog.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

import 'package:para_job/packages/user_manager/user_controller.dart';

class EmployerController extends GetxController {
  final int companyId;
  final user = Get.find<UserController>();
  var isAnonymous = false.obs;
  var hasSubmittedReview = false.obs;

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

  void goToEmployerReviews() {
    Get.toNamed(
      "${Routes.jobDetails}${Routes.employer}${Routes.employerReviews}",
      arguments: {'id': companyId},
    );
  }

  void goToActiveJobs() {
    Get.toNamed(
      "${Routes.jobDetails}${Routes.employer}${Routes.activeJobs}",
      arguments: {'id': companyId},
    );
  }

  Future<void> fetchCompany() async {
    companyCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchCompany(
        id: companyId,
        token: user.token,
      );

      if (response.isSuccess == true) {
        companyData = response.data;
        companyCallState.value = ApiCallState.success;
      } else {
        companyCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("Error fetching employer: ${e.toString()}");
      companyCallState.value = ApiCallState.failure;
    }
  }
  void triggerReviewSubmitted() {
    hasSubmittedReview.value = !hasSubmittedReview.value;
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
        isAnonymous: isAnonymous.value,
      );

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
          hasSubmittedReview.value = true;
          Get.find<EmployerController>(tag: companyId.toString())
              .triggerReviewSubmitted();
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
