//Mary Mark ||  mary.mark@moselaymd.com || Wed Jan 14 2026 14:35:04

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/home/home_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class HomeDepartmentChips extends StatelessWidget {
  const HomeDepartmentChips({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final departments = controller.departmentsData;
    if (departments == null || departments.isEmpty) {
      return const SizedBox.shrink();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: departments.map((dept) {
          final isFirst = dept.id == -1;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wPct(1)),
            child: ChoiceChip(
              label: Text(dept.name),
              selected: isFirst,
              showCheckmark: false,
              onSelected: (_) {},
              selectedColor: Colors.white,
              backgroundColor: Colors.transparent,
              side: BorderSide(
                color: isFirst ? AppColors.pureWhite : AppColors.softWhite70,
              ),
              labelStyle: TextStyle(
                color: isFirst
                    ? AppColors.charcoalBlack
                    : AppColors.softWhite70,
                fontWeight: isFirst ? FontWeight.bold : FontWeight.normal,
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
