//Mary Mark ||  mary.mark@moselaymd.com || Wed Jan 14 2026 14:35:04

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/home_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class HomeDepartmentChips extends StatelessWidget {
  HomeDepartmentChips({super.key});
  final controller = Get.find<HomeController>();
  late final departments = controller.departmentsData;

  @override
  Widget build(BuildContext context) {
    if (departments == null || departments!.isEmpty) {
      return const SizedBox.shrink();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: departments!.map((dept) {
          final isAllDepartments = dept.id == -1;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wPct(1)),
            child: ChoiceChip(
              label: Text(dept.name),
              selected: isAllDepartments,
              showCheckmark: false,
              onSelected: (_) {},
              selectedColor: Colors.white,
              backgroundColor: Colors.transparent,
              side: BorderSide(
                color: isAllDepartments ? AppColors.pureWhite : AppColors.softWhite70,
              ),
              labelStyle: TextStyle(
                color: isAllDepartments
                    ? AppColors.charcoalBlack
                    : AppColors.softWhite70,
                fontWeight: isAllDepartments ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.wPct(4)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
