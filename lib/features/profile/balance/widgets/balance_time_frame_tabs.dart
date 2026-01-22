import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class BalanceTimeFrameTabs extends StatelessWidget {
  BalanceTimeFrameTabs({super.key});

  final BalanceController _controller = Get.find<BalanceController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: BalanceTab.values.map((tab) {
          final isSelected = _controller.selectedTab == tab;

          return GestureDetector(
            onTap: () => _controller.updateSelectedTab(tab),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wPct(3)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.wPct(4),
                  vertical: context.hPct(1),
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.darkGray : Colors.transparent,
                  borderRadius: BorderRadius.circular(context.wPct(5)),
                ),
                child: Text(
                  tab.displayName,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.pureWhite
                        : AppColors.silverGray,
                    fontSize: context.wPct(4),
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
