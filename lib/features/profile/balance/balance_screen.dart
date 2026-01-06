import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/features/profile/balance/widgets/balance_histor_section.dart';
import 'package:para_job/features/profile/balance/widgets/time_frame.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
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
        child: Padding(
          padding: EdgeInsets.all(context.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  AppAssetPaths.balanceCoinIconwithStars,
                  height: context.hPct(12.5),
                ),
              ),
              context.hBox(2.5),
              Text(
                'balance_your_balance'.tr,
                style: TextStyle(
                  color: AppColors.silverGray,
                  fontSize: context.wPct(4.5),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'balance_currency'.tr,
                      style: TextStyle(
                        color: AppColors.silverGray,
                        fontSize: context.wPct(5),
                      ),
                    ),
                    TextSpan(
                      text: '12,000',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.wPct(7.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              context.hBox(2.5),

              // Tab Row wrapped in Obx
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: BalanceTab.values.map(
                    (tab) {
                      return TimeFrame(
                        title: tab.displayName,
                        isSelected: _balanceController.selectedTab == tab,
                        onTap: () => _balanceController.updateSelectedTab(tab),
                      );
                    },
                  ).toList(), // .map returns an Iterable, so convert it to a List
                ),
              ),

              context.hBox(2.5),

              // Dynamic Colored Container wrapped in Obx
              Obx(
                () => Container(
                  width: double.infinity,
                  height: context.hPct(25),
                  decoration: BoxDecoration(
                    color: _balanceController.getContainerColor(),
                    borderRadius: BorderRadius.circular(context.wPct(4)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Showing ${_balanceController.selectedTab} Data",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: context.wPct(4.5),
                    ),
                  ),
                ),
              ),

              context.hBox(2.5),

              // History Section
              BalanceHistorySection(),
            ],
          ),
        ),
      ),
    );
  }
}
