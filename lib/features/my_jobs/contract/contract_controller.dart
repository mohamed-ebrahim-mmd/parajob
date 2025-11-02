import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart' show PagingController;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/api_client/src/models/responses/contract.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:signature/signature.dart';

import '../../../packages/api_client/src/models/requests/application_verification_request.dart';
import '../../../packages/themeing/app_colors.dart';
import '../../../packages/ui_components/show_snack_bar_message.dart';
import '../../../packages/user_manager/user_controller.dart';

class ContractController extends GetxController {
  final int jobId;
  final PagingController<int, MyJob> approvedJobController ;

  final user = Get.find<UserController>();
  final signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: AppColors.aquaTeal,
  );
  var contractCallState = ApiCallState.loading.obs;
  var isAgreed = false.obs;
  Contract? contract;
  ContractController({required this.approvedJobController, required this.jobId});

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
      showSnackBarError("Failed" ,"Please sign before continuing.");
      return;
    }

    try {
      context.loaderOverlay.show();
      final signatureBytes = await signatureController.toPngBytes();
      if (signatureBytes == null) {
        showSnackBarError("Failed" ,"Failed to generate signature image");
      }

      final multipartFile = MultipartFile.fromBytes(
        signatureBytes!,
        filename: "signature.png",
      );

      final uploadResponse = await apiClient.uploadFile([multipartFile]);

      final uploadedUrl = uploadResponse.url ?? "";

      if (uploadedUrl.isEmpty) {
        showSnackBarError("Failed","No file URL returned from upload API");
      }

      final response = await apiClient.applicationVerification(
        token: user.token!,
        request: ApplicationVerificationRequest(
          jobId: jobId.toString(),
          signature: uploadedUrl,
        ),
      );
      showSnackBarSuccess('Success', response.details?.message ?? "contract Signed");
      Get.until(
            (route) =>
        Get.currentRoute ==
            Routes.mainNavigator,
      );
      approvedJobController.refresh();
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
