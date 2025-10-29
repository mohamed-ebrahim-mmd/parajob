/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-22 1:27 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/jobs/jobs_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class DepartmentChips extends StatelessWidget {
  const DepartmentChips({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobsController>();

    return Obx(() {
      final departments = controller.departments ?? [];

      if (departments.isEmpty) {
        return const SizedBox.shrink();
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: departments.map((dept) {
            final isSelected = controller.selectedDepartmentId.value == dept.id;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wPct(1)),
              child: ChoiceChip(
                label: Text(dept.name),
                selected: isSelected,
                showCheckmark: false,
                onSelected: (_) => controller.selectDepartment(dept.id ?? -1),
                selectedColor: Colors.white,
                backgroundColor: Colors.transparent,
                side: BorderSide(
                  color: isSelected
                      ? AppColors.pureWhite
                      : AppColors.softWhite70,
                ),
                labelStyle: TextStyle(
                  color: isSelected
                      ? AppColors.charcoalBlack
                      : AppColors.softWhite70,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.wPct(4)),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
