import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/registration/create_account_otp/create_account_otp_controller.dart';
import 'package:para_job/features/registration/widgets/stepper.dart';
import 'package:para_job/packages/route_manager/controller/routes.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/themeing/theme.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_button/timer_button.dart';

class CreateAccountOtpScreen extends StatelessWidget {
  CreateAccountOtpScreen({super.key});

  final controller = Get.find<CreateAccountOtpController>();

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
          padding: EdgeInsets.symmetric(horizontal: context.defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.hBox(2),
                StepperRow(currentStep: 0, stepPercentage: "0%"),

                Text(
                  'create_account_otp_title'.tr,
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                context.hBox(0.5),
                Text(
                  'create_account_otp_subtitle'.tr,
                  style: TextStyle(
                    color: AppColors.softWhite70,
                    fontSize: context.wPct(3.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                context.hBox(4),
                Pinput(
                  controller: controller.pinController,
                  length: 5,
                  defaultPinTheme: AppTheme.pinTheme(context),
                  focusedPinTheme: AppTheme.pinTheme(context).copyWith(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.aquaTeal, width: 3),
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
            vertical: context.hPct(2.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FilledButton(
                onPressed: () {
                  /*       Get.toNamed(
                    "${Routes.createAccount}${Routes.createAccountOTP}${Routes.createAccountSetPass}",
                  );*/
                  controller.verifyOtp(context);
                },
                child: Text('create_account_otp_verify_button'.tr),
              ),
              context.hBox(2),
              TimerButton(
                label: 'create_account_otp_resend_button'.tr,
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
                  controller.resendOtpRequest(context);
                },
              ),
              context.hBox(5),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.contactUsAuth),
                child: Text(
                  'create_account_otp_contact_us'.tr,
                  style: TextStyle(
                    color: AppColors.aquaTeal,
                    fontSize: context.wPct(4.2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
