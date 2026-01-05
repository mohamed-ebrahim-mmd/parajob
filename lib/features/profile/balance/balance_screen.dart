// Karim Toson || kareemtoson1@gmail.com || 5/1/2026 10:50AM

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/features/profile/balance/widgets/balance_history_widget.dart';
import 'package:para_job/features/profile/balance/widgets/item_tap.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/res/app_asset_paths.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BalanceController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //svg image
              Center(
                child: SvgPicture.asset(AppAssetPaths.balanceCoinIconwithStars),
              ),
              SizedBox(height: 20),
              //text
              const Text(
                'Your balance',
                style: TextStyle(color: AppColors.silverGray, fontSize: 18),
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'EGP ',
                      style: TextStyle(
                        color: AppColors.silverGray,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: '12,000',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TabItem(
                      title: 'Week',
                      isSelected: controller.selectedPeriod.value == 'Week',
                      onTap: () => controller.selectPeriod('Week'),
                    ),
                    TabItem(
                      title: 'Month',
                      isSelected: controller.selectedPeriod.value == 'Month',
                      onTap: () => controller.selectPeriod('Month'),
                    ),
                    TabItem(
                      title: 'Year',
                      isSelected: controller.selectedPeriod.value == 'Year',
                      onTap: () => controller.selectPeriod('Year'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => BalanceHistorySection(
                  period: controller.selectedPeriod.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
