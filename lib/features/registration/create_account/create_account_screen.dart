/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-12 2:48 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/registration/create_account/create_account_controller.dart';
import 'package:para_job/features/registration/widgets/stepper.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart'
    show ApiCallState, DataFetchState;
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CreateAccountScreen extends StatelessWidget {
  final controller = Get.put(CreateAccountController());

  CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepperRow(currentStep: 0, stepPercentage: "0%"),

              Text(
                'create_account_title'.tr,
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(7),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(3.5),
              Text(
                'create_account_main_info'.tr,

                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(5),
                  fontWeight: FontWeight.w500,
                ),
              ),
              context.hBox(2.5),
              Obx(() {
                return TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    errorText: controller.nameError.value,
                    hintText: 'create_account_name_hint'.tr,
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                );
              }),
              context.hBox(1.5),
              // Date of Birth TF
              Obx(() {
                final textValue = controller.selectedDate.value;
                return TextField(
                  readOnly: true,
                  controller: TextEditingController(text: textValue),
                  decoration: InputDecoration(
                    errorText: controller.dateError.value,
                    hintText: textValue.isEmpty
                        ? 'create_account_dob_hint'.tr
                        : textValue,
                  ),
                  onTap: controller.pickDate,
                );
              }),
              context.hBox(1.5),

              Obx(() {
                return TextField(
                  controller: controller.phoneController,
                  decoration: InputDecoration(
                    errorText: controller.phoneError.value,

                    hintText: 'create_account_phone_hint'.tr,
                  ),
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                );
              }),
              context.hBox(1.5),
              // Email Address TF
              Obx(() {
                return TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    errorText: controller.emailError.value,

                    hintText: 'create_account_email_hint'.tr,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                );
              }),
              context.hBox(1.5),

              Obx(() {
                return TextField(
                  controller: controller.nationalIdController,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    errorText: controller.nationalIdError.value,
                    hintText: 'create_account_id_hint'.tr,
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                );
              }),
              context.hBox(1.5),
              Obx(() {
                return DropdownMenu<String>(
                  enableSearch: true,
                  expandedInsets: EdgeInsets.zero,
                  errorText: controller.genderError.value,

                  hintText: 'create_account_gender_hint'.tr,
                  initialSelection: controller.selectedGender,
                  onSelected: controller.onGenderSelected,
                  dropdownMenuEntries: controller.genderMenuEntries,
                );
              }),
              context.hBox(2.5),

              Text(
                'create_account_location_info'.tr,

                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(5),
                  fontWeight: FontWeight.w500,
                ),
              ),
              context.hBox(2.5),
              Obx(() {
                switch (controller.citiesCallState.value) {
                  case ApiCallState.loading:
                    return TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'create_account_loading_cities'.tr,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    );

                  case ApiCallState.success:
                    return DropdownMenu<int>(
                      enableSearch: true,
                      expandedInsets: EdgeInsets.zero,
                      menuHeight: context.hPct(30),
                      errorText: controller.cityError.value,
                      hintText: 'create_account_city_hint'.tr,
                      initialSelection: controller.selectedCityId.value,
                      onSelected: controller.onCitySelected,
                      dropdownMenuEntries: controller.cityMenuEntries,
                    );

                  case ApiCallState.failure:
                    return GestureDetector(
                      onTap: controller.fetchCities,
                      child: AbsorbPointer(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'create_account_failed_load_retry'.tr,
                            suffixIcon: Icon(Icons.refresh),
                          ),
                        ),
                      ),
                    );
                }
              }),
              context.hBox(1.5),

              Obx(() {
                switch (controller.areasCallState.value) {
                  case DataFetchState.loading:
                    return TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'create_account_loading_areas'.tr,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    );

                  case DataFetchState.success:
                    return DropdownMenu<int>(
                      enableSearch: true,
                      expandedInsets: EdgeInsets.zero,
                      menuHeight: context.hPct(30),
                      hintText: 'create_account_area_hint'.tr,
                      errorText: controller.areaError.value,
                      initialSelection: controller.selectedAreaId,
                      onSelected: (value) {
                        if (value != null) {
                          controller.selectedAreaId = value;
                        }
                      },
                      dropdownMenuEntries: controller.areaMenuEntries,
                    );

                  case DataFetchState.failure:
                    return GestureDetector(
                      onTap: () {
                        if (controller.selectedCityId.value != null) {
                          controller.fetchAreas(
                            controller.selectedCityId.value!,
                          );
                        }
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'create_account_failed_load_areas'.tr,
                            suffixIcon: Icon(Icons.refresh),
                          ),
                        ),
                      ),
                    );

                  case DataFetchState.initial:
                    return TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'create_account_select_city_first'.tr,
                      ),
                    );
                }
              }),

              context.hBox(2.5),

              FilledButton(
                onPressed: controller.registerUser,
                child: Text('create_account_continue_button'.tr),
              ),

              context.hBox(5),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.contactUsAuth),
                child: Text(
                  'create_account_contact_us'.tr,
                  style: TextStyle(
                    color: AppColors.aquaTeal,
                    fontSize: context.wPct(4.2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              context.hBox(2.8),
            ],
          ),
        ),
      ),
    );
  }
}
