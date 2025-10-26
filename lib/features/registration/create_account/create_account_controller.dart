/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-26 3:24 PM
 ==================================================================
*/
import 'package:flutter/material.dart' show DropdownMenuEntry;
import 'package:get/get.dart';
import 'package:para_job/packages/api_client/api_client.dart';

class CreateAccountController extends GetxController {
  final citiesCallState = ApiCallState.loading.obs;
  final areasCallState = DataFetchState.initial.obs;
  int? selectedAreaId;
  final selectedCityId = Rx<int?>(null);
  List<DropdownMenuEntry<int>> cityMenuEntries = [];
  List<DropdownMenuEntry<int>> areaMenuEntries = [];

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

  void onCitySelected(int? value) {
    if (value != null && value != selectedCityId.value) {
      selectedCityId.value = value;
      selectedAreaId = null;
      fetchAreas(value);
    }
  }

  Future<void> fetchAreas(int cityId) async {
    areasCallState.value = DataFetchState.loading;

    try {
      final response = await apiClient.getAreasByCity(cityId);
      if (response.isSuccess) {
        areaMenuEntries = response.data
            .map(
              (area) =>
                  DropdownMenuEntry<int>(value: area.id, label: area.name),
            )
            .toList();
        areasCallState.value = DataFetchState.success;
      } else {
        areasCallState.value = DataFetchState.failure;
      }
    } catch (e) {
      areasCallState.value = DataFetchState.failure;
    }
  }
}
