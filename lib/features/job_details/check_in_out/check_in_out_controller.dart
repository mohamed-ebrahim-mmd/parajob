import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/packages/api_client/src/models/requests/check_in_out_request.dart';
import 'package:para_job/packages/api_client/src/models/responses/check_in_out_history.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

import '../../../packages/api_client/src/enums/api_call_state_enum.dart';
import '../../../packages/api_client/src/service/api_client_instance.dart';
import '../../../packages/ui_components/show_snack_bar_message.dart';

class CheckInOutController extends GetxController {
  final int jobId;
  final bool? initialHasAttendance;
  var hasAttendance = false.obs;
  final user = Get.find<UserController>();
  var callState = ApiCallState.loading.obs;
  var activeCheckInOutHistory = Rxn<CheckInOutHistory>();
  var shiftHours = 0.obs;
  var checkInStatus = false.obs;
  var checkOutStatus = false.obs;

  CheckInOutController({
    required this.jobId,
    this.initialHasAttendance = false,
  });
  @override
  void onInit() {
    super.onInit();
    hasAttendance.value = initialHasAttendance!;
    getActiveCheckInOut();
  }

  Future<void> scan(BuildContext context, String code) async {
    try {
      context.loaderOverlay.show();
      final response = await apiClient.scanCheckInOut(
        token: user.token!,
        request: CheckInOutRequest(
          jobId: jobId,
          code: code,
          scannedAt: DateTime.now(),
          type: hasAttendance.value == true ? 'check_out' : 'check_in',
        ),
      );

      if (response.isSuccess == true) {
        if (hasAttendance.value == false) {
          hasAttendance.value = true;
          checkInStatus.value = true;
          getActiveCheckInOut();
        } else {
          checkOutStatus.value = true;
          getLastCheckInOut();
        }
      } else {
        showSnackBarError(
          "failed_title".tr,
          response.details?.message ?? "unknown_error".tr,
        );
      }
    } catch (e) {
      showSnackBarApiError();
      print(e);
    } finally {
      context.loaderOverlay.hide();
    }
  }

  Future<void> getActiveCheckInOut() async {
    if (hasAttendance.value == false) {
      callState.value = ApiCallState.success;
      return;
    }

    callState.value = ApiCallState.loading;

    try {
      final response = await apiClient.getActiveCheckInOut(
        jobId: jobId,
        token: user.token!,
      );
      if (response.isSuccess) {
        activeCheckInOutHistory.value = response.data;
        shiftHours.value = calculateShiftHours(
          response.data.job?.from,
          response.data.job?.to,
        );
        callState.value = ApiCallState.success;
      } else {
        callState.value = ApiCallState.failure;
      }
    } catch (e) {
      print("🔴 ${e.toString()}");
      callState.value = ApiCallState.failure;
    }
  }

  Future<void> getLastCheckInOut() async {
    callState.value = ApiCallState.loading;

    try {
      final response = await apiClient.getCheckInOutHistory(
        jobId: jobId,
        token: user.token!,
        page: 1
      );
      if (response.isSuccess) {
        activeCheckInOutHistory.value = response.data?[0];
        callState.value = ApiCallState.success;
      } else {
        callState.value = ApiCallState.failure;
      }
    } catch (e) {
      print("🔴🔴🔴🔴🔴🔴");
      print("🔴 ${e.toString()}");
      callState.value = ApiCallState.failure;
    }
  }

  int calculateShiftHours(String? from, String? to) {
    if (from == null || to == null) return 0;

    final fromParts = from.split(':').map(int.parse).toList();
    final toParts = to.split(':').map(int.parse).toList();

    final fromTime = DateTime(
      0,
      1,
      1,
      fromParts[0],
      fromParts[1],
      fromParts[2],
    );
    final toTime = DateTime(0, 1, 1, toParts[0], toParts[1], toParts[2]);

    final duration = toTime.difference(fromTime);
    return duration.inHours;
  }

  void closeAndDispose() {
    Get.back();
    Get.delete<CheckInOutController>();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
