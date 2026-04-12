/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-23 2:58 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/search_job/search_job_controller.dart';
import 'package:para_job/packages/api_client/src/enums/api_call_state_enum.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

Future<void> showFilterBottomSheet(
  BuildContext context,
  SearchJobController controller,
) async {
  await Get.bottomSheet(
    enterBottomSheetDuration: Duration(milliseconds: 50),
    Container(
      padding: EdgeInsets.all(context.wPct(5)),
      decoration: BoxDecoration(
        color: AppColors.dialogBackgroundDark,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.wPct(6)),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Center(
              child: Container(
                alignment: Alignment.center,
                width: context.wPct(20),
                height: context.hPct(.5),
                decoration: BoxDecoration(
                  color: AppColors.lightGray2,
                  borderRadius: BorderRadius.circular(context.wPct(2)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // pushes content to the end
              crossAxisAlignment: CrossAxisAlignment.center,
              // vertically center
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.close,
                    color: AppColors.lightGray,
                    size: context.hPct(3),
                  ),
                ),
              ],
            ),
            context.hBox(3),

            // title
            Text(
              'filter'.tr,
              style: TextStyle(
                fontSize: context.wPct(4),
                fontWeight: FontWeight.w600,
              ),
            ),
            context.hBox(2),

            Row(
              children: [
                Expanded(
                  child: DropdownMenu<String>(
                    enableSearch: true,
                    width: context.wPct(90),
                    menuHeight: context.hPct(30),
                    controller: controller.jobTypeController,
                    hintText: 'job_type'.tr,
                    onSelected: (value) {
                      if (value != null) {
                        controller.selectedJobType = value;
                      }
                    },
                    dropdownMenuEntries: controller.jobTypeMenuEntries,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    controller.selectedJobType = null;
                    controller.jobTypeController.clear();
                  },
                ),
              ],
            ),
            context.hBox(2),

            Row(
              children: [
                Expanded(
                  child: DropdownMenu<int>(
                    enableSearch: true,
                    width: context.wPct(90),
                    menuHeight: context.hPct(30),
                    controller: controller.cityController,
                    hintText: 'city'.tr,
                    onSelected: controller.onCitySelected,
                    dropdownMenuEntries: controller.cities,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    controller.selectedCityId = null;
                    controller.cityController.clear();
                    controller.areaController.clear();
                    controller.selectedArea = null;
                  },
                ),
              ],
            ),
            context.hBox(2),

            Obx(() {
              switch (controller.areasCallState.value) {
                case DataFetchState.loading:
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'create_account_loading_areas'.tr,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.transparent,
                        ),
                        onPressed: null,
                      ),
                    ],
                  );

                case DataFetchState.success:
                  return Row(
                    children: [
                      Expanded(
                        child: DropdownMenu<String>(
                          enableSearch: true,
                          expandedInsets: EdgeInsets.zero,
                          menuHeight: context.hPct(30),
                          hintText: 'area'.tr,
                          controller: controller.areaController,
                          onSelected: (value) {
                            if (value != null) {
                              controller.selectedArea = value;
                            }
                          },
                          dropdownMenuEntries: controller.areaMenuEntries,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          controller.selectedArea = null;
                          controller.areaController.clear();
                        },
                      ),
                    ],
                  );

                case DataFetchState.failure:
                  return GestureDetector(
                    onTap: () {
                      if (controller.selectedCityId != null) {
                        controller.fetchAreas(controller.selectedCityId!);
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
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(labelText: 'area'.tr),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.transparent,
                        ),
                        onPressed: null,
                      ),
                    ],
                  );
              }
            }),

            context.hBox(2),
            Row(
              children: [
                Expanded(
                  child: DropdownMenu<int>(
                    enableSearch: true,
                    width: context.wPct(90),
                    menuHeight: context.hPct(30),
                    controller: controller.skillController,
                    hintText: 'skills'.tr,
                    onSelected: (value) {
                      if (value != null) controller.selectedSkillId = value;
                    },
                    dropdownMenuEntries: controller.skills,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    controller.selectedSkillId = null;
                    controller.skillController.clear();
                  },
                ),
              ],
            ),
            context.hBox(2),

            Row(
              children: [
                Expanded(
                  child: DropdownMenu<int>(
                    enableSearch: true,
                    menuHeight: context.hPct(30),
                    width: context.wPct(90),
                    controller: controller.companyController,
                    hintText: 'company'.tr,
                    onSelected: (value) {
                      if (value != null) controller.selectedCompanyId = value;
                    },
                    dropdownMenuEntries: controller.companies,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    controller.selectedCompanyId = null;
                    controller.companyController.clear();
                  },
                ),
              ],
            ),
            context.hBox(2),

            Row(
              children: [
                Expanded(
                  child: DropdownMenu<String>(
                    enableSearch: true,
                    menuHeight: context.hPct(30),
                    width: context.wPct(90),
                    controller: controller.categoryController,
                    hintText: 'categories'.tr,
                    onSelected: (value) {
                      if (value != null) controller.selectedJobCategory = value;
                    },
                    dropdownMenuEntries: controller.jobCategoriesEntries,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    controller.selectedJobCategory = null;
                    controller.categoryController.clear();
                  },
                ),
              ],
            ),
            context.hBox(.5),

            //reset filters
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton.icon(
                label: Text(
                  'reset_filters'.tr,
                  style: TextStyle(color: AppColors.gray8D),
                ),
                icon: Icon(Icons.refresh, color: AppColors.gray8D),

                onPressed: controller.resetFilters,
              ),
            ),
            context.hBox(.5),
            // button
            FilledButton(
              onPressed: controller.applyFilters,
              child: Text('apply_filter'.tr),
            ),
            context.hBox(2),
          ],
        ),
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}
