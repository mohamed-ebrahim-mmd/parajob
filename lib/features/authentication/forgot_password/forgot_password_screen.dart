/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-12 2:49 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/authentication/forgot_password/forgot_password_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new), // Or your custom icon
          onPressed: () {
            Navigator.of(context).pop(); // Handle back action
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
                'Forgot Password',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(8.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              context.hBox(0.5),
              Text(
                'please enter your phone number to receive\n your verification OTP',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(3.5),
                  fontWeight: FontWeight.w500,
                ),
              ),

              context.hBox(5),
              Obx(() {
                return TextField(
                  controller: controller.phoneController,
                  decoration: InputDecoration(
                    errorText: controller.phoneError.value,
                    hintText: "Enter your phone number",
                  ),
                  keyboardType: TextInputType.phone,
                );
              }),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.wPct(5),
          vertical: context.hPct(12),
        ),
        child: FilledButton(
          onPressed: controller.forgotPassword,
          child: Text("Send"),
        ),
      ),
    );
  }
}
