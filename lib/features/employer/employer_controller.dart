import 'dart:developer';

import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';

class EmployerController extends GetxController {
  final int companyId;

  EmployerController(this.companyId);

  var companyCallState = ApiCallState.loading.obs;
  Company? companyData;

  @override
  void onInit() {
    super.onInit();
    fetchCompany();
  }

  Future<void> fetchCompany() async {
    companyCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchCompany(companyId);

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
}
