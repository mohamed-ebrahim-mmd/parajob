import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/api_client/src/models/requests/edit_user_request.dart';
import 'package:para_job/packages/api_client/src/service/api_client_instance.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:para_job/packages/user_manager/user_controller.dart';

class EditMainInfoController extends GetxController {
  EditMainInfoController({required this.context});

  final citiesCallState = ApiCallState.loading.obs;
  final areasCallState = DataFetchState.initial.obs;
  int? selectedAreaId;
  final profileController = Get.find<ProfileController>();
  late final user = profileController.profileData;
  final String token = Get.find<UserController>().token!;
  final selectedCityId = Rx<int?>(null);
  List<DropdownMenuEntry<int>> cityMenuEntries = [];
  List<DropdownMenuEntry<int>> areaMenuEntries = [];
  final BuildContext context;

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

        // ✅ Set the user's current city *after* fetching cities
        final userCityName = user?.city;
        if (userCityName != null && userCityName.isNotEmpty) {
          final matchedCity = response.data.firstWhereOrNull(
            (city) => city.name == userCityName,
          );

          if (matchedCity != null) {
            selectedCityId.value = matchedCity.id;
            // optionally fetch areas for that city
            fetchAreas(matchedCity.id);
          }
        }

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

        final useAreaName = user?.area;
        if (useAreaName != null && useAreaName.isNotEmpty) {
          final matchedArea = response.data.firstWhereOrNull(
            (area) => area.name == useAreaName,
          );

          if (matchedArea != null) {
            selectedAreaId = matchedArea.id;
          }
        }

        areasCallState.value = DataFetchState.success;
      } else {
        areasCallState.value = DataFetchState.failure;
      }
    } catch (e) {
      areasCallState.value = DataFetchState.failure;
    }
  }

  void editUser() async {
    // City
    if (selectedCityId.value == null) {
      showSnackBarError("Failed", 'Please select your city');
      return;
    }

    //  Area
    if (selectedAreaId == null) {
      showSnackBarError("Failed", 'Please select your area');
      return;
    }

    await editUserProfile(
      EditUserRequest(areaId: selectedAreaId, cityId: selectedCityId.value),
    );
  }

  Future<void> editUserProfile(
    // BuildContext context,
    EditUserRequest request,
  ) async {
    context.loaderOverlay.show();
    try {
      final response = await apiClient.updateUserProfile(request, token);
      if (response.isSuccess) {
        await profileController.fetchProfileDetails();
        log("🟢 isSuccess");
        showSnackBarSuccess(
          "success",
          response.details.message ?? "edit successfully",
        );
      } else {
        showSnackBarError("Failed", response.details.message ?? "edit failed");
        log(response.details.message ?? "edit failed");
      }
    } catch (e) {
      log("🔴 ${e.toString()}");
      showSnackBarError("Failed", e.toString());
    } finally {
      context.loaderOverlay.hide();
    }
  }
}
