//Mary Mark ||  mary.mark@moselaymd.com || Thu Nov 20 2025 17:50:49

import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/api_client/src/models/responses/strike.dart';
import 'package:para_job/packages/api_client/src/service/api_client_instance.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class NotificationStrikeController extends GetxController {
  final userController = Get.find<UserController>();
  var strikesCallState = ApiCallState.loading.obs;
  List<Strike> strikesData = [];

  @override
  void onInit() {
    super.onInit();
    fetchStrikesDetails();
  }

  Future<void> fetchStrikesDetails() async {
    strikesCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchStrikes(userController.token!);

      if (response.isSuccess) {
        log("🟢 fetchProfileDetails isSuccess");
        strikesData = response.data;

        strikesCallState.value = ApiCallState.success;
      } else {
        strikesCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      strikesCallState.value = ApiCallState.failure;
    }
  }


  String getFormattedDate(String dateString, {String locale = 'en'}) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('d MMMM yyyy', locale).format(dateTime);
    } catch (_) {
      return dateString; // fallback if parsing fails
    }
  }




}
