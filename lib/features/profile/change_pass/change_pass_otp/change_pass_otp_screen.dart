//Mary Mark ||  mary.mark@moselaymd.com || Tue Nov 11 2025 12:25:00

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/change_pass/change_pass_otp/change_pass_otp_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/themeing/theme.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_button/timer_button.dart';

class ChangePassOtpScreen extends StatelessWidget {
  ChangePassOtpScreen({super.key});
  final controller = Get.put(ChangePassOtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: Get.back,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.hBox(2),
              Text(
                'change_pass_otp_title'.tr,
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(0.5),
              Text(
                'change_pass_otp_subtitle'.tr,
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(3.5),
                  fontWeight: FontWeight.w500,
                ),
              ),

              context.hBox(5),
              Center(
                child: Pinput(
                  controller: controller.pinController,
                  length: 5,
                  defaultPinTheme: AppTheme.pinTheme(context),
                  focusedPinTheme: AppTheme.pinTheme(context).copyWith(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.aquaTeal,
                          width: context.wPct(0.3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: context.wPct(2),
                  top: context.hPct(1),
                ),
                child: Obx(() {
                  return Text(
                    controller.pinError.value ?? "",
                    style: TextStyle(
                      color: AppColors.coralRed, // Hint text
                      fontSize: context.wPct(3),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.wPct(5),
          vertical: context.hPct(7),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () {
                controller.verifyOtp(context);
              },
              child: Text('change_pass_otp_verify_button'.tr),
            ),
            context.hBox(4),
            TimerButton(
              label: 'change_pass_otp_resend_button'.tr,
              timeOutInSeconds: 59,
              buttonType: ButtonType.outlinedButton,
              activeTextStyle: TextStyle(
                color: AppColors.pureWhite,
                fontSize: context.wPct(4.2),
              ),
              disabledTextStyle: TextStyle(
                color: AppColors.grayButton,
                fontSize: context.wPct(4.2),
              ),
              color: AppColors.pureWhite,
              disabledColor: AppColors.grayButton,
              onPressed: () {
                controller.resendChangePasswordRequest(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
