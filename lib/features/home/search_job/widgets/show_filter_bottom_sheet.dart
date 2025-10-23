/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-23 2:58 PM
 ==================================================================
*/
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/search_job/search_job_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

void showFilterBottomSheet() {
  final context = Get.context!;
  final controller = Get.find<SearchJobController>();

  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(context.wPct(5)),
      decoration: BoxDecoration(
        color: AppColors.midnightBlue,
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
                onTap: () {
                  Get.back();
                },
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
            "Filter",
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
            hintText: 'Job type',
            onSelected: (value) {
              if (value != null) {
                controller.selectedJobType = value;
              }
            },
            dropdownMenuEntries: controller.jobTypeMenuEntries,
          ),
          context.hBox(2),
          DropdownMenu<int>(
            enableSearch: true,
            menuHeight: context.hPct(30),
            initialSelection: controller.selectedSkillId,

            width: double.infinity,
            hintText: 'Skills',
            onSelected: (value) {
              if (value != null) {
                controller.selectedSkillId = value;
              }
            },
            dropdownMenuEntries: controller.skills
                .map(
                  (skill) => DropdownMenuEntry<int>(
                    value: skill.id,
                    label: skill.name,
                  ),
                )
                .toList(),
          ),
          context.hBox(2),
          DropdownMenu<int>(
            enableSearch: true,
            menuHeight: context.hPct(30),
            width: double.infinity,
            initialSelection: controller.selectedCompanyId,
            hintText: 'Company',
            onSelected: (value) {
              if (value != null) {
                controller.selectedCompanyId = value;
              }
            },
            dropdownMenuEntries: controller.companies
                .map(
                  (company) => DropdownMenuEntry<int>(
                    value: company.id,
                    label: company.name,
                  ),
                )
                .toList(),
          ),
          context.hBox(2),
          DropdownMenu<String>(
            enableSearch: true,
            menuHeight: context.hPct(30),
            width: double.infinity,
            initialSelection: controller.selectedJobCategory,
            hintText: 'Categories ',
            onSelected: (value) {
              if (value != null) {
                controller.selectedJobCategory = value;
              }
            },
            dropdownMenuEntries: controller.jobCategoriesEntries,
          ),
          context.hBox(2),
          // button
          FilledButton(
            onPressed: () {
              log("🟢 ${controller.selectedSkillId}");
            },
            child: Text("Apply Filter"),
          ),
          context.hBox(2),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}
