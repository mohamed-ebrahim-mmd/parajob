// Karim Toson || kareemtoson1@gmail.com || 5/1/2026 10:50AM

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:para_job/features/profile/balance/widgets/balance_history_widget.dart';
import 'package:para_job/features/profile/balance/widgets/item_tap.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/res/app_asset_paths.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(5),
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
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TabItem(title: 'Week', isSelected: false),
                  TabItem(title: 'Month', isSelected: true),
                  TabItem(title: 'Year', isSelected: false),
                ],
              ),
              SizedBox(height: 20),
              BalanceHistorySection(),
            ],
          ),
        ),
      ),
    );
  }
}
