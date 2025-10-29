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
        padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepperRow(currentStep: 0, stepPercentage: "0%"),

              context.hBox(4),
              Text(
                'Create a new account',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(6),
              Text(
                'Main Information',

                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(5),
                  fontWeight: FontWeight.w500,
                ),
              ),
              context.hBox(2.5),
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(hintText: "Enter your Full Name"),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              context.hBox(1.5),
              // Date of Birth TF
              Obx(() {
                final textValue = controller.selectedDate.value;
                return TextField(
                  readOnly: true,
                  controller: TextEditingController(text: textValue),
                  decoration: InputDecoration(
                    hintText: textValue.isEmpty
                        ? "Enter your Date of Birth"
                        : textValue,
                  ),
                  onTap: controller.pickDate,
                );
              }),
              context.hBox(1.5),

              TextField(
                controller: controller.phoneController,
                decoration: InputDecoration(
                  hintText: "Enter your phone Number",
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              context.hBox(1.5),
              // Email Address TF
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(hintText: "Enter your Email"),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              context.hBox(1.5),

              TextField(
                controller: controller.nationalIdController,
                decoration: InputDecoration(hintText: "Enter your id number"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              context.hBox(1.5),
              DropdownMenu<String>(
                enableSearch: true,
                expandedInsets: EdgeInsets.zero,
                hintText: "Choose your gender",
                initialSelection: controller.selectedGender,
                onSelected: controller.onGenderSelected,
                dropdownMenuEntries: controller.genderMenuEntries,
              ),
              context.hBox(2.5),

              Text(
                'Location  information',

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
                        labelText: "Loading cities...",
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
                      hintText: "Choose your city",
                      initialSelection: controller.selectedCityId.value,
                      onSelected: controller.onCitySelected,
                      dropdownMenuEntries: controller.cityMenuEntries,
                    );

                  case ApiCallState.failure:
                    return TextField(
                      readOnly: true,
                      onTap: () {
                        controller.fetchCities();
                      },

                      decoration: InputDecoration(
                        labelText: "Failed to load, tap to retry",
                        suffixIcon: const Icon(Icons.refresh),
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
                        labelText: "Loading areas...",
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
                      hintText: "Choose your city",
                      initialSelection: controller.selectedAreaId,
                      onSelected: (value) {
                        if (value != null) {
                          controller.selectedAreaId = value;
                        }
                      },
                      dropdownMenuEntries: controller.areaMenuEntries,
                    );

                  case DataFetchState.failure:
                    return TextField(
                      readOnly: true,
                      onTap: () {
                        if (controller.selectedCityId.value != null) {
                          controller.fetchAreas(
                            controller.selectedCityId.value!,
                          );
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Failed to load areas, tap to retry",
                        suffixIcon: const Icon(Icons.refresh),
                      ),
                    );

                  case DataFetchState.initial:
                    return TextField(
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: "Select a city first",
                      ),
                    );
                }
              }),
              context.hBox(2.5),

              FilledButton(
                onPressed: controller.registerUser,
                child: Text("Continue"),
              ),

              context.hBox(5),
              GestureDetector(
                child: Text(
                  "contact us",
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
