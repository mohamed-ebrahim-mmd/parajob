import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/features/profile/balance/widgets/balance_alert_dialog.dart';
import 'package:para_job/features/profile/balance/widgets/balance_history_widget.dart';
import 'package:para_job/features/profile/balance/widgets/item_tap.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/res/app_asset_paths.dart';

class BalanceScreen extends StatelessWidget {
  BalanceScreen({super.key});

  final BalanceController _balanceController = Get.put(BalanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    AppAssetPaths.balanceCoinIconwithStars,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),

                // Tab Row wrapped in Obx
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TabItem(
                        title: 'Week',
                        isSelected: _balanceController.selectedTab == 'Week',
                        onTap: () =>
                            _balanceController.updateSelectedTab('Week'),
                      ),
                      TabItem(
                        title: 'Month',
                        isSelected: _balanceController.selectedTab == 'Month',
                        onTap: () =>
                            _balanceController.updateSelectedTab('Month'),
                      ),
                      TabItem(
                        title: 'Year',
                        isSelected: _balanceController.selectedTab == 'Year',
                        onTap: () =>
                            _balanceController.updateSelectedTab('Year'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Dynamic Colored Container wrapped in Obx
                Obx(
                  () => Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: _balanceController.getContainerColor(),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Showing ${_balanceController.selectedTab} Data",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // History Section
                GestureDetector(
                  onTap: () {
                    showDeductionDialog(context);
                  },
                  child: const BalanceHistorySection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
