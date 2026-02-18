/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-23 2:58 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/search_job/search_job_controller.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // drag handle
          Row(
            children: [
              Spacer(flex: 5),
              Container(
                alignment: Alignment.center,
                width: context.wPct(20),
                height: context.hPct(.5),
                decoration: BoxDecoration(
                  color: AppColors.lightGray2,
                  borderRadius: BorderRadius.circular(context.wPct(2)),
                ),
              ),
              Spacer(flex: 4),
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

          DropdownMenu<String>(
            enableSearch: true,
            width: context.wPct(90),
            menuHeight: context.hPct(30),
            initialSelection: controller.selectedJobType,
            hintText: 'job_type'.tr,
            onSelected: (value) {
              if (value != null) controller.selectedJobType = value;
            },
            dropdownMenuEntries: controller.jobTypeMenuEntries,
          ),
          context.hBox(2),

          DropdownMenu<int>(
            enableSearch: true,
            width: context.wPct(90),
            menuHeight: context.hPct(30),
            initialSelection: controller.selectedCityId,
            hintText: 'city'.tr,
            onSelected: (value) {
              if (value != null) controller.selectedCityId = value;
            },
            dropdownMenuEntries: controller.cities,
          ),
          context.hBox(2),

          DropdownMenu<int>(
            enableSearch: true,
            width: context.wPct(90),
            menuHeight: context.hPct(30),
            initialSelection: controller.selectedSkillId,
            hintText: 'skills'.tr,
            onSelected: (value) {
              if (value != null) controller.selectedSkillId = value;
            },
            dropdownMenuEntries: controller.skills,
          ),
          context.hBox(2),

          DropdownMenu<int>(
            enableSearch: true,
            menuHeight: context.hPct(30),
            width: context.wPct(90),
            initialSelection: controller.selectedCompanyId,
            hintText: 'company'.tr,
            onSelected: (value) {
              if (value != null) controller.selectedCompanyId = value;
            },
            dropdownMenuEntries: controller.companies,
          ),
          context.hBox(2),

          DropdownMenu<String>(
            enableSearch: true,
            menuHeight: context.hPct(30),
            width: context.wPct(90),
            initialSelection: controller.selectedJobCategory,
            hintText: 'categories'.tr,
            onSelected: (value) {
              if (value != null) controller.selectedJobCategory = value;
            },
            dropdownMenuEntries: controller.jobCategoriesEntries,
          ),
          context.hBox(2),

          // button
          FilledButton(
            onPressed: controller.applyFilters,
            child: Text('apply_filter'.tr),
          ),
          context.hBox(2),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}
