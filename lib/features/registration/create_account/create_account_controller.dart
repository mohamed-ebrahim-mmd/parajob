/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-26 3:24 PM
 ==================================================================
*/
import 'package:flutter/cupertino.dart' show TextEditingController;
import 'package:flutter/material.dart' show DropdownMenuEntry, showDatePicker;
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:para_job/features/registration/create_account_otp/create_account_otp_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart'
    show Routes;
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart'
    show showSnackBarError;

class CreateAccountController extends GetxController {
  final citiesCallState = ApiCallState.loading.obs;
  final areasCallState = DataFetchState.initial.obs;
  RxString selectedDate = ''.obs;
  final nameController = TextEditingController();
  final nationalIdController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  int? selectedAreaId;
  String? selectedGender;
  final selectedCityId = Rx<int?>(null);
  List<DropdownMenuEntry<int>> cityMenuEntries = [];
  List<DropdownMenuEntry<int>> areaMenuEntries = [];
  final List<DropdownMenuEntry<String>> genderMenuEntries = const [
    DropdownMenuEntry(value: 'male', label: 'Male'),
    DropdownMenuEntry(value: 'female', label: 'Female'),
  ];

  @override
  void onInit() {
    super.onInit();
    fetchCities();
  }

  Future<void> pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      selectedDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
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

  // Handle selection
  void onGenderSelected(String? value) {
    selectedGender = value;
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

  void registerUser() async {
    // 🧹 Trim all text fields before validation
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final nationalId = nationalIdController.text.trim();

    // 1️⃣ Name
    final nameError = validateName(name);
    if (nameError != null) {
      showSnackBarError("Failed", nameError);
      return;
    }

    // 2️⃣ Date of Birth
    if (selectedDate.value.isEmpty) {
      showSnackBarError("Failed", 'Birth date cannot be empty');
      return;
    }

    // 3️⃣ Phone Number
    final phoneError = validateEgyptianPhone(phone);
    if (phoneError != null) {
      showSnackBarError("Failed", phoneError);
      return;
    }

    // 4️⃣ Email
    final emailError = validateEmail(email);
    if (emailError != null) {
      showSnackBarError("Failed", emailError);
      return;
    }

    // 5️⃣ National ID
    final idError = validateEgyptianNationalId(nationalId);
    if (idError != null) {
      showSnackBarError("Failed", idError);
      return;
    }

    // 6️⃣ Gender
    if (selectedGender == null) {
      showSnackBarError("Failed", 'Please select your gender');
      return;
    }

    // 7️⃣ City
    if (selectedCityId.value == null) {
      showSnackBarError("Failed", 'Please select your city');
      return;
    }

    // 8️⃣ Area
    if (selectedAreaId == null) {
      showSnackBarError("Failed", 'Please select your area');
      return;
    }

    // ✅ All validations passed
    Get.put(CreateAccountOtpController(phone.trim()));
    Get.toNamed("${Routes.createAccount}${Routes.createAccountOTP}");
  }

  // ✅ Dispose method to avoid memory leaks
  @override
  void onClose() {
    nameController.dispose();
    nationalIdController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
