/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-15 10:44 AM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/authentication/set_new_password/set_new_password_controller.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class SetNewPasswordScreen extends StatelessWidget {
  final controller = Get.find<SetNewPasswordController>();

   SetNewPasswordScreen({super.key});

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
                  'Set password',
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: context.wPct(8.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                context.hBox(6),
                Obx(() {
                  return TextField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      hintText: "Enter your new password",
                      errorText: controller.passwordError.value,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                  );
                }),
                context.hBox(1.5),
                Obx(() {
                  return TextField(
                    controller: controller.confirmPasswordController,
                    decoration: InputDecoration(
                      errorText: controller.confirmPasswordError.value,
                      hintText: "Confirm your new Password",
                    ),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
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
            onPressed: () {
              controller.validateAndSubmit(context);
              // Get.toNamed("${Routes.forgotPassword}${Routes.forgotPasswordOTP}");
            },
            child: Text("Confirm"),
          ),
        ),
      ),
    );
  }
}
