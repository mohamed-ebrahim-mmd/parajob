import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/api_client/src/service/api_client_instance.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';

class EditMainInfoController extends GetxController {
  final citiesCallState = ApiCallState.loading.obs;
  final areasCallState = DataFetchState.initial.obs;
  int? selectedAreaId;
  var user = Get.find<ProfileController>().profileData;

  final selectedCityId = Rx<int?>(null);
  List<DropdownMenuEntry<int>> cityMenuEntries = [];
  List<DropdownMenuEntry<int>> areaMenuEntries = [];
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    setEmail();
    fetchCities();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }


  void setEmail(){
    emailController.text = user?.email ?? '';
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


  void registerUser() async {
 
    final email = emailController.text.trim();

  
    // 4️ Email
    final emailError = validateEmail(email);
    if (emailError != null) {
      showSnackBarError("Failed", emailError);
      return;
    }


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

    // ✅ All validations passed


    // Get.put(CreateAccountOtpController(phone.trim()));
    // Get.toNamed("${Routes.createAccount}${Routes.createAccountOTP}");
  
  
  }



}
