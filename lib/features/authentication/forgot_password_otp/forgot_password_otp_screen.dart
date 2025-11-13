/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-15 10:32 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/authentication/forgot_password_otp/forgot_password_otp_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/themeing/theme.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_button/timer_button.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  ForgotPasswordOtpScreen({super.key});
  final controller = Get.find<ForgotPasswordOtpController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          controller.closeAndDispose();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: controller.closeAndDispose,
          ),
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wPct(5)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.hBox(2),
                Text(
                  'forgot_password_otp_title'.tr,
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(8.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                context.hBox(0.5),
                Text(
                  'forgot_password_otp_subtitle'.tr,
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
                            width: context.wPct(0.5),
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
                child: Text('forgot_password_otp_verify_button'.tr),
              ),
              context.hBox(4),
              TimerButton(
                label: 'forgot_password_otp_resend_button'.tr,
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
                  controller.resendForgotPasswordRequest(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
