import 'package:flutter/cupertino.dart' show TextEditingController;
import 'package:flutter/material.dart' show DropdownMenuEntry, showDatePicker;
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:para_job/features/registration/create_account_otp/create_account_otp_controller.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/functional_components/validation_utils.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart'
    show Routes;

class CreateAccountController extends GetxController {
  final citiesCallState = ApiCallState.loading.obs;
  final areasCallState = DataFetchState.initial.obs;
  RxString selectedDate = ''.obs;
  final nameController = TextEditingController();
  final nationalIdController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  var emailError = RxnString(null);
  var nameError = RxnString(null);
  var nationalIdError = RxnString(null);
  var phoneError = RxnString(null);
  var dateError = RxnString(null);
  var areaError = RxnString(null);
  var genderError = RxnString(null);
  var cityError = RxnString(null);

  int? selectedAreaId;
  String? selectedGender;
  final selectedCityId = Rx<int?>(null);
  List<DropdownMenuEntry<int>> cityMenuEntries = [];
  List<DropdownMenuEntry<int>> areaMenuEntries = [];
  final List<DropdownMenuEntry<String>> genderMenuEntries = [
    DropdownMenuEntry(value: 'male', label: "male".tr),
    DropdownMenuEntry(value: 'female', label: 'female'.tr),
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
            .where(
              (city) =>
                  city.id != null && city.name != null && city.name!.isNotEmpty,
            )
            .map(
              (city) =>
                  DropdownMenuEntry<int>(value: city.id!, label: city.name!),
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
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final nationalId = nationalIdController.text.trim();

    nameError.value = validateName(name);
    phoneError.value = validateEgyptianPhone(phone);
    emailError.value = validateEmail(email);
    dateError.value = validateBirthDate(selectedDate.value);
    nationalIdError.value = validateEgyptianNationalId(nationalId);
    genderError.value = validateGender(selectedGender);
    cityError.value = validateCity(selectedCityId.value);
    areaError.value = validateArea(selectedAreaId);

    if (nameError.value == null &&
        phoneError.value == null &&
        emailError.value == null &&
        nationalIdError.value == null &&
        dateError.value == null &&
        genderError.value == null &&
        cityError.value == null &&
        areaError.value == null) {
      proceedToOtpVerification(phone);
    }
  }

  void proceedToOtpVerification(String phone) {
    Get.put(CreateAccountOtpController(phone.trim()));
    Get.toNamed("${Routes.createAccount}${Routes.createAccountOTP}");
  }

  @override
  void onClose() {
    nameController.dispose();
    nationalIdController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
