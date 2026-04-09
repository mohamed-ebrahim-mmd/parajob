import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart'
    show PagingController;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:signature/signature.dart';

import '../../../packages/themeing/app_colors.dart';
import '../../../packages/ui_components/show_snack_bar_message.dart';
import '../../../packages/user_manager/user_controller.dart';

class ContractController extends GetxController {
  final int jobId;
  final PagingController<int, MyJob> approvedJobController;

  final user = Get.find<UserController>();
  final signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: AppColors.softWhite70,
  );
  var contractCallState = ApiCallState.loading.obs;
  var isAgreed = false.obs;
  Contract? contract;

  ContractController({
    required this.approvedJobController,
    required this.jobId,
  });

  @override
  void onInit() {
    super.onInit();
    fetchContract();
  }

  Future<void> fetchContract() async {
    contractCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.getContract();
      if (response.isSuccess) {
        log("🟢 Contract fetched successfully");
        contract = response.data;
        contractCallState.value = ApiCallState.success;
      } else {
        log("🔴 Contract API returned failure");
        contractCallState.value = ApiCallState.failure;
      }
    } catch (e, s) {
      log("🔴 Error fetching contract: $e", stackTrace: s);
      contractCallState.value = ApiCallState.failure;
    }
  }

  Future<void> verify(BuildContext context) async {
    if (signatureController.isEmpty) {
      showSnackBarError("failed_title".tr, "please_sign".tr);
      return;
    }

    try {
      context.loaderOverlay.show();
      final signatureBytes = await signatureController.toPngBytes();
      if (signatureBytes == null) {
        showSnackBarError("failed_title".tr, "signature_generation_failed".tr);
        return;
      }

      final multipartFile = MultipartFile.fromBytes(
        signatureBytes,
        filename: "signature.png",
      );

      final uploadResponse = await apiClient.uploadFile([multipartFile]);
      final uploadedUrl = uploadResponse.urls?.first ?? "-";

      if (uploadedUrl.isEmpty) {
        showSnackBarError("failed_title".tr, "no_file_url".tr);
        return;
      }

      final response = await apiClient.applicationVerification(
        token: user.token!,
        request: ApplicationVerificationRequest(
          jobId: jobId.toString(),
          signature: uploadedUrl,
        ),
      );

      if (response.isSuccess) {
        showJobContractSuccessSnackBar();

        Get.until((route) => Get.currentRoute == Routes.mainNavigator);
        approvedJobController.refresh();
        return;
      } else {
        showSnackBarApiError();
      }
    } catch (e, s) {
      log("Error verifying contract: $e", stackTrace: s);
      showSnackBarApiError();
    } finally {
      context.loaderOverlay.hide();
    }
  }

  void closeAndDispose() {
    Get.back();
    Get.delete<ContractController>();
  }

  @override
  void onClose() {
    signatureController.dispose();
    super.onClose();
  }
}
