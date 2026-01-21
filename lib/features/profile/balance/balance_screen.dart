import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/features/profile/balance/widgets/balance_histor_section.dart';
import 'package:para_job/features/profile/balance/widgets/time_frame.dart';
import 'package:para_job/packages/api_client/api_client.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/error_screen.dart';
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
        child: Obx(() {
          switch (_balanceController.balanceCallState.value) {
            case ApiCallState.loading:
              return const Center(child: CircularProgressIndicator());

            case ApiCallState.failure:
              return Center(
                child: ErrorScreen(
                  onPressed: _balanceController.fetchBalanceTransactions,
                ),
              );

            case ApiCallState.success:
              return Padding(
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
                            text: '12000',
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

                    /// Tabs
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: BalanceTab.values.map((tab) {
                        return TimeFrame(
                          title: tab.displayName,
                          isSelected: _balanceController.selectedTab == tab,
                          onTap: () =>
                              _balanceController.updateSelectedTab(tab),
                        );
                      }).toList(),
                    ),

                    context.hBox(2.5),

                    Container(
                      width: double.infinity,
                      height: context.hPct(25),
                      decoration: BoxDecoration(
                        color: _balanceController.getContainerColor(),
                        borderRadius: BorderRadius.circular(context.wPct(4)),
                      ),
                      padding: EdgeInsets.all(context.wPct(3)),
                      child: _balanceController.balanceData != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: _balanceController
                                        .balanceData!
                                        .chart
                                        .map(
                                          (item) => Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: context.hPct(0.5),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  item.label,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: context.wPct(3),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Text(
                                'No data available',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.wPct(4.5),
                                ),
                              ),
                            ),
                    ),

                    context.hBox(2.5),

                    BalanceHistorySection(),
                  ],
                ),
              );
          }
        }),
      ),
    );
  }
}
