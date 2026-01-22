import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/balance/balance_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class BalanceHeader extends StatelessWidget {
  BalanceHeader({super.key});

  final BalanceController _controller = Get.find<BalanceController>();

  String get _balance {
    return _controller.balanceData.value?.summary.totalBalance.toString() ??
        '0';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SvgPicture.asset(
            AppAssetPaths.balanceCoinIconwithStars,
            height: context.hPct(12.5),
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
                  text: _balance,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.wPct(7.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
