//Mary Mark ||  mary.mark@moselaymd.com || Mon Nov 24 2025 13:52:45

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  // final controller = Get.find<ForgotPasswordOtpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                context.hBox(2),
                Text(
                  'privacy_policy'.tr,
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(8.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                context.hBox(0.5),

                Text(
                  'privacy policy content',
                  style: TextStyle(
                    color: AppColors.softWhite70,
                    fontSize: context.wPct(3.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                context.hBox(5),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.wPct(5),
          vertical: context.hPct(2.8),
        ),
        child: Text(
          'last_updated'.tr,
          style: TextStyle(
            color: AppColors.aquaTeal,
            fontSize: context.wPct(4.2),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
