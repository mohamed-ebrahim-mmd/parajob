import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/edit_profile/edit_main_info/edit_main_info_controller.dart';
import 'package:para_job/features/profile/user_profile/profile_controller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class EditMainInfo extends StatelessWidget {
  EditMainInfo({super.key, required this.screenContext});

  final BuildContext screenContext;
  final user = Get.find<ProfileController>().profileData;
  late final controller = Get.put(
    EditMainInfoController(context: screenContext),
  );

  @override
  Widget build(context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              context.hBox(2),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  label: Text(user?.name ?? ""),
                  fillColor: AppColors.disabled,
                  filled: true,
                ),
              ),
    
              context.hBox(1.5),
              // Email Address TF
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  label: Text(user?.email ?? ""),
                  fillColor: AppColors.disabled,
                  filled: true,
                ),
              ),
              context.hBox(1.5),
              // Phone Number
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  label: Text(user?.phoneNumber ?? ""),
                  fillColor: AppColors.disabled,
                  filled: true,
                ),
              ),
              context.hBox(1.5),
              // DOB
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  label: Text(user?.dateOfBirth ?? ""),
                  fillColor: AppColors.disabled,
                  filled: true,
                ),
              ),
              context.hBox(1.5),
              // Gender
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  label: Text(user?.gender ?? ""),
                  fillColor: AppColors.disabled,
                  filled: true,
                ),
              ),
              context.hBox(1.5),
    
              // City
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
                    return GestureDetector(
                      onTap: controller.fetchCities,
                      child: AbsorbPointer(
                        child: TextField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: "Failed to load, tap to retry",
                            suffixIcon: Icon(Icons.refresh),
                          ),
                        ),
                      ),
                    );
                }
              }),
              context.hBox(1.5),
    
              // Area
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
                          decoration: const InputDecoration(
                            labelText: "Failed to load areas, tap to retry",
                            suffixIcon: Icon(Icons.refresh),
                          ),
                        ),
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
    
              Spacer(),
              FilledButton(
                onPressed: controller.editUser,
                child: Text("Save changes"),
              ),
              context.hBox(2.5),
            ],
          ),
        ),
      ],
    );
  }
}
