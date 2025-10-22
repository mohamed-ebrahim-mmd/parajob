

import 'dart:developer';

import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';

class CompanyDetailsController extends GetxController {
  var companyDetailsCallState = ApiCallState.loading.obs;
 CompanyDetailsResponse? companyData;
  final int compId;
  CompanyDetailsController(this.compId);

  @override
  void onInit() {
    super.onInit();
    fetchCompDetails(compId);
  }

  Future<void> fetchCompDetails(int id) async {
    companyDetailsCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.fetchCompanyDetails(id);

      if (response.isSuccess) {
        log("🟢 isSuccess");

        companyData = response;

        companyDetailsCallState.value = ApiCallState.success;
      } else {
        companyDetailsCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      log("🟢 ${e.toString()}");
      companyDetailsCallState.value = ApiCallState.failure;
    }
  }
}
