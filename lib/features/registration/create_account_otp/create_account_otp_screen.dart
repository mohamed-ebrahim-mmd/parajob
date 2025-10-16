import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_button/timer_button.dart';

class CreateAccountOtpScreen extends StatelessWidget {
  CreateAccountOtpScreen({super.key});
  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pinTheme = PinTheme(
      width: context.wPct(6),
      height: context.hPct(8),
      textStyle: TextStyle(
        fontSize: context.wPct(6),
        color: AppColors.pureWhite,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.pureWhite, width: 2),
        ),
      ),
    );
    return Scaffold(
          appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
                'Verify your number',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(0.5),
              Text(
                'check your messages to find the  OTP',
                style: TextStyle(
                  color: AppColors.softWhite70,
                  fontSize: context.wPct(3.5),
                  fontWeight: FontWeight.w500,
                ),
              ),

              context.hBox(5),
              Center(
                child: Pinput(
                  controller: _pinController,
                  length: 5,
                  defaultPinTheme: pinTheme,
                  focusedPinTheme: pinTheme.copyWith(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.aquaTeal, width: 3),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != '12345') return 'Invalid code';
                    return null;
                  },
                  onCompleted: (pin) {
                    debugPrint('Completed: $pin');
                  },
                ),
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
                // Get.toNamed(
                //   "${Routes.forgotPassword}${Routes.forgotPasswordOTP}${Routes.setNewPassword}",
                // );
              },
              child: Text("Verify"),
            ),
            context.hBox(4),
            TimerButton(
              label: "Send again",
              timeOutInSeconds: 5,
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
                // code to execute
              },
            ),
              context.hBox(5),
              GestureDetector(
                child: Text(
                  "contact us",
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
    );
  }
}
