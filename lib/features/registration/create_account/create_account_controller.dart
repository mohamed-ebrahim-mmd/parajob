/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-26 3:24 PM
 ==================================================================
*/
import 'package:flutter/material.dart' show DropdownMenuEntry;
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';

class CreateAccountController extends GetxController {
  final citiesCallState = ApiCallState.loading.obs;
  final selectedCityId = Rx<int?>(null);
  List<DropdownMenuEntry<int>> cityMenuEntries = [];

  @override
  void onInit() {
    super.onInit();
    fetchCities();
  }

  Future<void> fetchCities() async {
    citiesCallState.value = ApiCallState.loading;

    try {
      final response = await apiClient.getCities();
      if (response.isSuccess) {
        cityMenuEntries = response.data
            .map(
              (city) =>
                  DropdownMenuEntry<int>(value: city.id, label: city.name),
            )
            .toList();
        citiesCallState.value = ApiCallState.success;
      } else {
        citiesCallState.value = ApiCallState.failure;
      }
    } catch (e) {
      citiesCallState.value = ApiCallState.failure;
    }
  }
}
